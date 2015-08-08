require 'rails/generators'
require 'factory_girl_rails'

module Fakery
  module Generators
    class FakeryGenerator < Rails::Generators::NamedBase #:nodoc:

      SKIPED_COLUMN = %w{id created_at updated_at}
      def self.source_root
        @_factory_girl_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'factory_girl', generator_name, 'templates'))
      end

      def explicit_class_option
        ", class: '#{class_name}'" unless class_name == singular_table_name.camelize
      end

#       argument(
#         :attributes,
#         type: :array,
#         default: [],
#         banner: "field:type field:type"
#       )

      class_option(
        :dir,
        type: :string,
        default: "test/factories",
        desc: "The directory or file root where factories belong"
      )

      class_option(
        :suffix,
        type: :string,
        default: nil,
        desc: "Suffix to add factory file"
      )

      def create_fixture_file
        if File.exist?(factories_file)
          insert_factory_into_existing_file
        else
          create_factory_file
        end
      end

      private

      def factories_file
        options[:dir] + ".rb"
      end

      def insert_factory_into_existing_file
        insert_into_file(
          factories_file,
          factory_definition,
          after: "FactoryGirl.define do\n"
        )
      end

      def create_factory_file
        file = File.join(options[:dir], "#{filename}.rb")
        create_file(file, single_file_factory_definition)
      end

      def factory_definition
<<-RUBY
  factory :#{singular_table_name}#{explicit_class_option} do
#{factory_attributes.gsub(/^/, "    ")}
  end
RUBY
      end

      def single_file_factory_definition
<<-RUBY
FactoryGirl.define do
#{factory_definition.chomp}
end
RUBY
      end

      def factory_attributes
        class_name.constantize.columns.map do |attribute|
          unless SKIPED_COLUMN.include? attribute.name
            "#{attribute.name} #{attribute_default(attribute)}"
          end
        end.compact.join("\n")
      end

      def filename
        if factory_girl_options[:filename_proc].present?
          factory_girl_options[:filename_proc].call(table_name)
        else
          [table_name, filename_suffix].compact.join('_')
        end
      end

      def filename_suffix
        factory_girl_options[:suffix] || options[:suffix]
      end

      def factory_girl_options
        generators.options[:factory_girl] || {}
      end

      def generators
        config = FactoryGirl::Railtie.config
        config.respond_to?(:app_generators) ? config.app_generators : config.generators
      end

      def attribute_default(attribute)
        if attribute.default
          attribute.default
        else
          case attribute.type.to_s
          when "string"
            "\"MyString\""
          when "integer"
            1
          when "text"
            "\"MyText\""
          when "boolean"
            true
          when "datetime"
            "\"#{Time.now}\""
          end
        end
      end
    end
  end
end
