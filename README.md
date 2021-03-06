# Rubocop::Sorted

[![Gem Version](https://badge.fury.io/rb/rubocop-sorted.svg)](https://badge.fury.io/rb/rubocop-sorted)
![ruby workflow](https://github.com/HeroProtagonist/rubocop-sorted/actions/workflows/ruby.yml/badge.svg)

[Rubocop](https://github.com/rubocop/rubocop) extension used to enforce that the keys of a hash are sorted alphabetically

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-sorted', require: false
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubocop-sorted

## Usage

You need to tell RuboCop to load the Sorted extension. There are three ways to do this:

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-sorted
```

Alternatively, use the following array notation when specifying multiple extensions.

```yaml
require:
  - rubocop-other-extension
  - rubocop-sorted
```

Now you can run `rubocop` and it will automatically load the RuboCop Sorted cops together with the standard cops.

### Command line

```sh
rubocop --require rubocop-sorted
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rubocop-sorted. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rubocop-sorted/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rubocop::Sorted project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rubocop-sorted/blob/main/CODE_OF_CONDUCT.md).
