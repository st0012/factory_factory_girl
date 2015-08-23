require 'rails/generators'
require "factory_girl_rails"
require 'generators/factory_girl/model/model_generator'

module FactoryFactoryGirl
  module Generators
    class ModelGenerator < FactoryGirl::Generators::ModelGenerator
      SKIPED_COLUMN = %w{id created_at updated_at}

      private

      def factory_attributes
        class_name.constantize.columns.map do |attribute|
          unless SKIPED_COLUMN.include? attribute.name
            "#{attribute.name} #{set_column(attribute)}"
          end
        end.compact.join("\n    ")
      end

      def set_column(attribute)
        match_results = rules.map do |rule|
          if attribute.name.match(rule[:attributes])
            rule
          end
        end.compact

        if applied_rule = match_results.first
          if applied_rule[:value]
            transfer_value_type(applied_rule[:value], attribute.type)
          else
            "{ #{applied_rule[:function]} }"
          end
        else
          default_value(attribute)
        end
      end

      def transfer_value_type(value, type)
        case type
        when :string || :text
          "\"#{value}\""
        when :integer
          value.to_i
        else
          value
        end
      end

      def default_value(attribute)
        if attribute.default
          attribute.default
        else
          case attribute.type
          when :string
            "\"MyString\""
          when :text
            "\"MyText\""
          when :integer
            1
          when :boolean
            true
          when :datetime
            "\"#{Time.now}\""
          else
            nil
          end
        end
      end

      def rules
        if @rules
          @rules
        else
          FactoryFactoryGirl.configuration.rules
        end
      end
    end
  end
end
