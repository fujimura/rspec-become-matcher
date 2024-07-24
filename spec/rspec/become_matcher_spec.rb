require 'rspec/matchers/fail_matchers'
require 'rspec/become_matcher'

RSpec.configure do |config|
  config.include RSpec::Matchers::FailMatchers
  config.include RSpec::BecomeMatcher
end

RSpec.describe "expect { actual }.to become(expected)" do
  it 'waits until given expression becomes expected value' do
    value = 1

    Thread.new do
      sleep 1
      value = 2
    end

    expect(value).to eq 1

    expect { value }.to become(2)
  end

  it "fails when given expression doesn't become to expected value in default timeout time(3 second)" do
    value = 1

    Thread.new do
      sleep 4
      value = 2
    end

    expect(value).to eq 1

    expect {
      expect { value }.to become(2)
    }.to fail_with(/Expected 1 to become 2 in 3 second, but not/)
  end

  it 'can change timeout seconds with `within`' do
    value = 1

    Thread.new do
      sleep 3.5
      value = 2
    end

    expect(value).to eq 1

    expect { value }.to become(2).within(4)
  end

  it 'can change timeout seconds with `in`, which is depecated in favor of `within`' do
    value = 1

    Thread.new do
      sleep 3.5
      value = 2
    end

    expect(value).to eq 1

    expect { value }.to become(2).in(4)
  end

  it 'can assert with block' do
    value = 1

    Thread.new do
      value = 2
    end

    expect(value).to eq 1

    expect { value }.to become { |v| v == 2 }
  end

  it "shows good negated message" do
    value = 1

    Thread.new do
      sleep 1
      value = 2
    end

    expect(value).to eq 1

    expect {
      expect { value }.not_to become(2)
    }.to fail_with(/Expected 1 not to become 2 in 3 second/)
  end
end
