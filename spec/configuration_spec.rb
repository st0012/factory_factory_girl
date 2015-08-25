require "spec_helper"

describe FactoryFactoryGirl::Configuration do

  describe "#match" do
    it "stores pattern and results" do
      subject.match(/name/, value: "String")
      subject.match(/content/, value: "Text")

      expect(subject.rules).to match_array(
        [
          { pattern: /name/, value: "String" },
          { pattern: /content/, value: "Text" }
        ]
      )
    end
  end
end
