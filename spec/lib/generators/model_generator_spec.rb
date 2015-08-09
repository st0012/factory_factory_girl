require "spec_helper"

ModelGenerator = Fakery::Generators::ModelGenerator

describe ModelGenerator, type: :generator do
  destination File.expand_path("../../../../tmp", __FILE__)
  let(:generator) do
    ModelGenerator.new(["test"], dir: destination_root + "/spec/factories")
  end

  before do
    prepare_destination
    generator.create_fixture_file
  end

  it "creates file in right directory" do
    expect(destination_root).to have_structure do
      directory "spec" do
        directory "factories" do
          file "tests.rb" do
            contains "FactoryGirl"
          end
        end
      end
    end
  end
end
