# FactoryFactoryGirl

## Mission

FactoryGirl is a very useful gem, let us generates test data more efficiently. However, if you start new project very frequently, you will feel painful to write every project's factory, especially when most of them have some common ground.

For example, you use `FFaker::Job.title` to generate all your `name` or `title`'s attribute, and use `FFaker::Lorem.paragraph` to generate the `description` or `content`'s attribute. Then you just need to cope & paste in serveral factories, or even serveral project's factories.

So the mission of this gem is helping people generate their factory more quikly, with some pre-defined rules like:

```ruby
FactoryFactoryGirl.configure do |config|
  config.match(/name|title/, function: "FFaker::Job.title")
  config.match(/content|descripton/, function "FFaker::Lorem.paragraph")
end
```

And then type:

```
$ rails g factory_factory_girl:model post

# or 

$ rails g factory_factory_girl:model job
```

You will see

```ruby
FactoryGirl.define do
  ........
  name { FFaker::Job.title }
  content { FFaker::Lorem.paragraph }
  .......
end
```


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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/factory_factory_girl.

