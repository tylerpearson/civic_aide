require 'spec_helper'

describe String do

  context ".underscore" do
    before do
      @camel_case_strings = ["camelCase", "CamelCase", "stringTwoHumps", "StringHasThreeHumps"]
      @underscore_strings = ["camel_case", "camel_case", "string_two_humps", "string_has_three_humps"]
    end

    it "should convert camelcase strings to underscored strings" do
      @camel_case_strings.collect{|s| s = s.underscore}.should == @underscore_strings
    end
  end

end