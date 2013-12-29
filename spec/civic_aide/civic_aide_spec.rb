require 'spec_helper'

describe CivicAide do

  before do
    CivicAide.api_key = "samplekey"
  end

  it 'should include Forwardable' do
    CivicAide.extend(Forwardable)
  end

  describe ".representatives" do
    it "should include representatives" do
      expect(CivicAide).to respond_to(:representatives)
    end
  end

  describe ".elections" do
    it "should include elections" do
      expect(CivicAide).to respond_to(:elections)
    end
  end

end