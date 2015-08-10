require 'factory_girl'
require 'factory_factory_girl/configuration'
require 'rails'

module FactoryGirl
  class Railtie < Rails::Railtie

    initializer "factory_factory_girl.get_test_framework" do
      FactoryFactoryGirl.configure do |c|
        c.rails_options = if config.respond_to?(:app_generators)
                         config.app_generators.options[:rails]
                       else
                         config.generators.options[:rails]
                       end
      end
    end
  end
end


