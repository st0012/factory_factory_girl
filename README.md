[![Build Status](https://travis-ci.org/st0012/factory_factory_girl.svg?branch=master)](https://travis-ci.org/st0012/factory_factory_girl)
[![Code Climate](https://codeclimate.com/github/st0012/factory_factory_girl/badges/gpa.svg)](https://codeclimate.com/github/st0012/factory_factory_girl)

# FactoryFactoryGirl

## Mission

FactoryGirl is a very useful gem, which lets us generate test data more efficiently. However, if you start new projects very frequently, you will feel painful writing every project's factory, especially when most of them have some common attributes.

For example, you use `FFaker::Job.title` to generate all your `name` or `title`'s value, and use `FFaker::Lorem.paragraph` to generate the `description` or `content`'s value. Then you just need to cope & paste those methods in serveral columns, in serveral model's factories, or even in serveral project's factories.

So the mission of this gem is helping people generate their factory more quikly, with some pre-defined rules like:

```ruby
FactoryFactoryGirl.configure do |config|
  config.match(/name|title/, function: "FFaker::Job.title")
  config.match(/content|descripton/, function: "FFaker::Lorem.paragraph")
end
```

And type:

```
$ rails g factory_factory_girl:model post

# or 

$ rails g factory_factory_girl:model job
```

Then you will see you factory file have some pre-defined value.

```ruby
FactoryGirl.define do
  ........
  name { FFaker::Job.title }
  content { FFaker::Lorem.paragraph }
  .......
end
```

I think this is great because the rule you defined here, can be use in any other projects, and you won't need to copy & paste the setting of those frequently seen column's.


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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factory_factory_girl.

