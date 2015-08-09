module FactoryFactoryGirl
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :rules

    def initialize
      @rules = []
    end

    def match(rule, value: nil, function: nil)
      result = if value
                 "\"#{value}\""
               elsif function
                 "{ #{function} }"
               else
                 raise "Need to give attribute or process"
               end
      rules << { rule: rule, result: %Q(#{result}) }
    end
  end
end
