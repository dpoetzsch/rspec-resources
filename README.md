# rspec-resources

Create rspec tests for your rails resources with ease.
This gem provides an flexible and easy to use DSL for writing common tests for rails resources.
It integrates into rspec so you still have all the flexibility at hand for more complicated tests.
By default, this assumes an API conforming to the [JSON API](http://jsonapi.org) standard but other formats are supported as well.
Included features are:

* Convention of configuration: By assuming sensible defaults it is as easy as pie to create your resource tests
* Singular and plural resources (corresponding to `resource` and `resources` in rails' routes file)
* Support for easy testing of common header-based authentication
* Support for testing resources that are owned by a certain user (tests that only the owner can access the records)
* Create more complex tests with ease by building upon the provided infrastructure

**NOTE**:
While already being used in production this gem is still at an early stage.
At the moment I'm applying the gem to existing rails apps making sure the DSL is flexible enough to apply to a large range of applications.
I'll try to keep API changes to a minimum.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-resources'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-resources

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rspec-resources. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the rspec-resources project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rspec-resources/blob/master/CODE_OF_CONDUCT.md).
