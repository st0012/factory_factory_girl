require "spec_helper"

describe Fakery::Configuration do

  describe "#match" do
    it "stores rules and results" do
      subject.match(/name/, "String")
      subject.match(/content/, "Text")

      expect(subject.rules).to match_array(
        [
          { rule: /name/, result: "\"String\"" },
          { rule: /content/, result: "\"Text\"" }
        ]
      )
    end
  end
end
