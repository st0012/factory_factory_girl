require "spec_helper"

ModelGenerator = Fakery::Generators::ModelGenerator

describe ModelGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)
  let(:generator) do
    ModelGenerator.new(["Post"], dir: destination_root + "/spec/factories")
  end

  before do
    prepare_destination
    generator.create_fixture_file
  end

  it "creates file in right directory" do
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
end
