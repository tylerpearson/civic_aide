require 'spec_helper'

describe Hash do

  context ".rubyify_keys" do
    before do
      @hash1 = {"testOne" => "1", "TestTwo" => "2", :testThree => 3, :TestFour => 4, :testFiveSix => 56}
      @hash1.rubyify_keys!
      @hash2 = {"test_one" => "1", "test_two" => "2", "test_three" => 3, "test_four" => 4, "test_five_six" => 56}
    end

    it "should convert camelcased keys to underscored keys" do
      expect(@hash1).to eq(@hash2)
    end

    it "should not rubify Open Civic Data identifiers" do
      ocd = {"ocd-division/country:us/state:nc/county:durham" => "test"}
      ocd2 = ocd.clone
      ocd.rubyify_keys!
      expect(ocd).to eq(ocd2)
    end

  end

  context ".except!" do

    it "should remove the correct item" do
      deleted = {:one => "hello", :two => "hello"}
      deleted.except!(:two)
      expect(deleted).to eq({:one => "hello"})
    end

  end

  context ".change_zip!" do

    it "changes zip in simple hash" do
      one = {"zip" => "test", "hello" => "test"}
      one.change_zip!
      expect(one).to eq({"zipCode" => "test", "hello" => "test"})
    end

    it "changes zip in complex hash" do
      two = {"zip" => "test", "hello" => "test", "three" => {"zip" => "hello"}}
      two.change_zip!
      expect(two).to eq({"zipCode" => "test", "hello" => "test", "three" => {"zipCode" => "hello"}})
    end

  end

end