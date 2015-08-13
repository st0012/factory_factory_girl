[![Build Status](https://travis-ci.org/st0012/factory_factory_girl.svg?branch=master)](https://travis-ci.org/st0012/factory_factory_girl)
[![Code Climate](https://codeclimate.com/github/st0012/factory_factory_girl/badges/gpa.svg)](https://codeclimate.com/github/st0012/factory_factory_girl)

# FactoryFactoryGirl

## Mission

[FactoryGirl](https://github.com/thoughtbot/factory_girl/) is a really useful gem that lets us generate test data more efficiently. However, if you start with new projects very frequently, you will feel painful to write project's attributes, especially when most of them look commonly.

For example, you use `FFaker::Job.title` to generate all your `name` or `title`'s value, and use `FFaker::Lorem.paragraph` to generate `description` or `content`'s value. Then you just need to copy & paste those methods to serveral columns in serveral factories, or even in serveral project's factories.

So I created [FactoryFactoryGirl](https://github.com/st0012/factory_factory_girl). The mission of this gem is helping people generate their factory more quickly, with some pre-defined rules like:

```
FactoryFactoryGirl.configure do |config|
  config.match(/name|title/, function: "FFaker::Job.title")
  config.match(/content|descripton/, function: "FFaker::Lorem.paragraph")
end
```
And run:

```
$ rails g factory_factory_girl:model post
```
or 
```
$ rails g factory_factory_girl:model job
```

Then you will see you factory file have some pre-defined value.

```
FactoryGirl.define do
  ........
  name { FFaker::Job.title }
  content { FFaker::Lorem.paragraph }
  .......
end
```

And the rule you defined in this project can be used in any other projects. You won't need to copy & paste the setting of those frequently seen column's.

I think this gem could be helpful, but also needs a lot of work. So if you find any bugs or have some ideas of this project, please open an issue or email me, thanks. 😄


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory_factory_girl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install factory_factory_girl

## Usage

Set your generation rule in `initializers/factory_factory_girl` like

```ruby
FactoryFactoryGirl.configure do |config|
  config.match(/name|title/, function: "FFaker::Job.title")
  config.match(/content|descripton/, function: "FFaker::Lorem.paragraph")
  config.match(/id/, value: "10")
end
```

And run 

```
$ rails g factory_factory_girl:model YOUR_MODEL
```

**Notice that the default directory is `test/factories`** (this is inherit from `factory_girl_rails`), so if you put your factories somewhere else, you need to specify it like

```
$ rails g factory_factory_girl:model YOUR_MODEL --dir=spec/factories
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

- [Fork it](https://github.com/st0012/factory_factory_girl/fork)
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -am 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create a new Pull Request

## Wanted contribution topic

- More specs
- New feature
- Bug report/fix
