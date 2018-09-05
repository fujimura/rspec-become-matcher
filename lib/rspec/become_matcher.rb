require 'timeout'

module RSpec
  module BecomeMatcher
    class Matcher
      DEFAULT_LIMIT = 3
      attr_reader :expected, :limit, :current

      def initialize(expected)
        @expected = expected
        @limit = DEFAULT_LIMIT
      end

      def matches?(block)
        Timeout.timeout(limit) do
          @current = block.call until current == expected
          true
        end
      rescue Timeout::Error
        false
      end

      def in(limit)
        @limit = limit
        self
      end

      def failure_message
        <<~MESSAGE
        Expected #{current} to become #{expected} in #{limit.to_i} second, but not
        MESSAGE
      end

      def failure_message_when_negated
        <<~MESSAGE
        Expected #{current} not to become #{expected} in #{limit.to_i} second
        MESSAGE
      end

      def supports_block_expectations?
        true
      end
    end

    def become(expected)
      Matcher.new(expected)
    end
  end
end
