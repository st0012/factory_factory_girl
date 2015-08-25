module FactoryFactoryGirl
  class << self
    attr_accessor :configuration

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

    def match(pattern, value: nil, function: nil)
      raise "Need to give attribute or process" if value.nil? && function.nil?

      if value
        rules << { pattern: pattern, value: value }
      else
        rules << { pattern: pattern, function: function }
      end
    end
  end
end
