require 'spec_helper'

describe FactoryFactoryGirl do
  it 'has a version number' do
    expect(FactoryFactoryGirl::VERSION).not_to be nil
  end

  describe "#load_configuration" do
    subject { FactoryFactoryGirl }

    it "requires spec/helper when path contains spec" do
      expect(subject).to receive(:require).with("./spec/spec_helper")

      subject.load_configuration("spec/helper")
    end

    it "requires test/helper when path not contains spec" do
      expect(subject).to receive(:require).with("./test/test_helper")

      subject.load_configuration("test/helper")
    end

    it "raises custom error when LoadError raised" do
      expect { subject.load_configuration("some/path") }.to raise_error("Can't load configuration")
    end
  end
end
