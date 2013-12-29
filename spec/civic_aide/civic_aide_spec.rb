require 'spec_helper'

describe CivicAide do

  before do
    CivicAide.api_key = "samplekey"
  end

  after do
    CivicAide.official_only = false
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

  describe ".official_only" do
    it "should default to false" do
      expect(CivicAide.official_only).to eq(false)
    end

    it "should allow changing" do
      CivicAide.official_only = true
      expect(CivicAide.official_only).to eq(true)
    end
  end

end