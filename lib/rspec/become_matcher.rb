require 'timeout'

module RSpec
  module BecomeMatcher
    class Matcher
      DEFAULT_LIMIT = 3
      attr_reader :expected, :limit, :current, :expected_block, :was

      def initialize(expected, &block)
        @expected = expected
        @expected_block = block
        @limit = DEFAULT_LIMIT
      end

      def matches?(block)
        Timeout.timeout(limit) do
          @was = @current = block.call
          @current = begin
                       sleep 0.1
                       block.call
                     end until matching_now?
          true
        end
      rescue Timeout::Error
        false
      end

      def matching_now?
        if expected_block
          expected_block.call(current)
        else
          current == expected
        end
      end

      def in(limit)
        @limit = limit
        self
      end

      def failure_message
        <<~MESSAGE
        Expected #{was} to become #{expected || 'given block'} in #{limit.to_i} second, but not
        MESSAGE
      end

      def failure_message_when_negated
        <<~MESSAGE
        Expected #{was} not to become #{expected || 'given block'} in #{limit.to_i} second
        MESSAGE
      end

      def supports_block_expectations?
        true
      end
    end

    def become(expected=nil, &block)
      # TODO raise with no expected nor block
      Matcher.new(expected, &block)
    end
  end
end
