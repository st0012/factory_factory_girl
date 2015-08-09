require "spec_helper"

describe FactoryFactoryGirl::Configuration do

  describe "#match" do
    it "stores rules and results" do
      subject.match(/name/, value: "String")
      subject.match(/content/, value: "Text")

      expect(subject.rules).to match_array(
        [
          { rule: /name/, result: "\"String\"" },
          { rule: /content/, result: "\"Text\"" }
        ]
      )
    end
  end
end
