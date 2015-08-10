module FactoryFactoryGirl
  class << self
    attr_accessor :configuration

    def load_configuration
      if configuration.rails_options[:test_framework] == :rspec
        require "./spec/spec_helper"
      else
        require "./test/test_helper"
      end
    rescue LoadError
      raise "Can't load configuration"
    end

    def configure
      self.configuration ||= Configuration.new
      yield(configuration) if block_given?
    end
  end

  class Configuration
    attr_accessor :rules, :rails_options

    def initialize
      @rules = []
      @rails_options = {}
    end

    def match(rule, value: nil, function: nil)
      raise "Need to give attribute or process" if                 value.nil? && function.nil?

      if value
        rules << { rule: rule, value: value }
      else
        rules << { rule: rule, function: function }
      end
    end
  end
end
