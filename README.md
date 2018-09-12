# Rspec::BecomeMatcher [![Build Status](https://travis-ci.org/fujimura/rspec-become-matcher.svg?branch=master)](https://travis-ci.org/fujimura/rspec-become-matcher)

RSpec matcher to check that an expression changed its result in arbitrary seconds.

```ruby
async_task.start!
expect { async_task.finished? }.to become(true)
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-become-matcher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-become-matcher

## Usage

```ruby
# Start some asynchronous task
async_task.start!

# `become` matcher checkes the task is `finished?` periodically
expect { async_task.finished? }.to become(true) # => PASS

# Start long asynchronous task
long_task.start!

# By default, `become` matcher waits 3 seconds.
expect { long_task.finished? }.to become(true) # => FAIL

# Start long asynchronous task, which finishes in 5 seconds
another_long_task.start!

# Timeout seconds can be specified with `in`
expect { another_long_task.finished? }.to become(true).in(10) # => PASS

# Expectation can be specified with block
yet_another_long_task.start!
expect { yet_another_long_task }.to become { |task| task.finished? } # => PASS
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fujimura/rspec-become-matcher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rspec::Become::Matcher project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fujimura/rspec-become-matcher/blob/master/CODE_OF_CONDUCT.md).
