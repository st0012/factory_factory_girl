module FactoryFactoryGirl
  class << self
    attr_accessor :configuration

    def configure
      if ENV["RAILS_ENV"] != "production"
        self.configuration ||= Configuration.new
        yield(configuration) if block_given?
      end
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
