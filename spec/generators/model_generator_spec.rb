require "spec_helper"

ModelGenerator = FactoryFactoryGirl::Generators::ModelGenerator

describe ModelGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)

  subject do
    ModelGenerator.new(["Post"], dir: destination_root + "/spec/factories")
  end

  before do
    FactoryFactoryGirl.configure do |config|
      config.rails_options = { test_framework: :rspec }
    end
  end

  describe "#create_fixture_file" do
    before do
      prepare_destination
    end

    it "creates file in right directory" do
      subject.create_fixture_file

      expect(destination_root).to have_structure {
        directory "spec" do
          directory "factories" do
            file "posts.rb" do
              contains "FactoryGirl.define"
              contains "title \"MyString\""
              contains "user_id 1"
              contains "is_published true"
              contains "view_count 1"
              contains "description \"MyText\""
              contains "content \"MyText\""
            end
          end
        end
      }
    end

    describe "generates factory with configuration" do
      before do
        FactoryFactoryGirl.configure do |f|
          f.match(/title/, value: "This is title")
          f.match(/content/, function: "[a..z].sample")
          f.match(/id/, value: 10)
        end
      end
      it "sets custom attribute" do
        subject.create_fixture_file

        expect(destination_root).to have_structure {
          directory "spec" do
            directory "factories" do
              file "posts.rb" do
                contains "FactoryGirl.define"
                contains "title \"This is title\""
                contains "user_id 10"
                contains "is_published true"
                contains "view_count 1"
                contains "description \"MyText\""
                contains "content { [a..z].sample }"
              end
            end
          end
        }
      end
    end
  end

  describe "#attirubte_default" do
    let(:attribute) { double(:attribute) }

    context "Attribute has default value" do
      it "returns default attribute" do
        allow(attribute).to receive(:default).and_return("123")

        result = subject.send(:default_value, attribute)

        expect(result).to eq("123")
      end
    end

    context "Attribute doesn't have default value" do
      before do
        allow(attribute).to receive(:default).and_return(nil)
      end

      it "returns \"MyString\" when type is string" do
        allow(attribute).to receive_message_chain(:type).and_return(:string)

        result = subject.send(:default_value, attribute)

        expect(result).to eq("\"MyString\"")
      end

      it "returns \"MyText\" when type is text" do
        allow(attribute).to receive_message_chain(:type).and_return(:text)

        result = subject.send(:default_value, attribute)

        expect(result).to eq("\"MyText\"")
      end

      it "returns 1 when type is integer" do
        allow(attribute).to receive_message_chain(:type).and_return(:integer)

        result = subject.send(:default_value, attribute)

        expect(result).to eq(1)
      end

      it "return 1.2 when type is float" do
        allow(attribute).to receive_message_chain(:type).and_return(:float)

        result = subject.send(:default_value, attribute)

        expect(result).to eq(1.2)
      end

      it "returns datetime when type is datetime" do
        allow(attribute).to receive_message_chain(:type).and_return(:datetime)

        result = subject.send(:default_value, attribute)

        expect(result).to match(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/)
      end

      it "returns nil when type is not yet defined" do
        allow(attribute).to receive_message_chain(:type).and_return(:hstore)

        result = subject.send(:default_value, attribute)

        expect(result).to be_nil
      end
    end
  end
end
