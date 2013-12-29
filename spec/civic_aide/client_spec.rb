require 'spec_helper'

describe CivicAide::Client do

  before do
    @client = CivicAide::Client.new("AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY")
  end

  describe '.new' do
    it 'raises an error with no API key' do
      CivicAide.api_key = nil
      expect{ CivicAide::Client.new }.to raise_error(APIKeyNotSet)
    end

    it "doesn't raise an error with class API key set" do
      CivicAide.api_key = "AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY"
      expect{ CivicAide::Client.new }.to_not raise_error
    end

    it "defaults to false for official only" do
      expect(@client.official_only).to eq(false)
    end
  end

  describe "#new" do
    it "takes one parameter and returns a Client object" do
      @client.should be_an_instance_of CivicAide::Client
    end
  end

  describe 'configuration' do
    it 'should have correct API endpoint' do
      expect(CivicAide::Client::API_ENDPOINT).to eq('https://www.googleapis.com/civicinfo/')
    end

    it 'should have the correct API version' do
      expect(CivicAide::Client::API_VERSION).to eq('us_v1')
    end

    it 'should include HTTParty' do
      @client.extend(HTTParty)
    end

    it 'should have the correct base_uri' do
      expect(CivicAide::Client.base_uri).to eq('https://www.googleapis.com/civicinfo/us_v1')
    end
  end

  describe '#default_query' do
    it 'should have the api key' do
      expect(@client.send(:default_query)).to eq({:key => @client.api_key, :prettyPrint => false})
    end
  end

  describe "#elections" do
    it "should be the right class" do
      expect(@client.elections).to be_an_instance_of CivicAide::Elections
    end
  end

  describe "#representatives" do
    it "should be the right class" do
      expect(@client.representatives).to be_an_instance_of CivicAide::Representatives
    end
  end

  describe "#classify_error" do
    it "should raise an error with NoAddressParameter" do
      expect{ @client.send(:check_response_status, "noAddressParameter") }.to raise_error("NoAddressParameter")
    end

    it "should raise an error with ElectionIdMissing" do
      expect{ @client.send(:check_response_status, "electionIdMissing") }.to raise_error("ElectionIdMissing")
    end

    it "should raise an error with NoStreetSegmentFound" do
      expect{ @client.send(:check_response_status, "noStreetSegmentFound") }.to raise_error("NoStreetSegmentFound")
    end

    it "should raise an error with AddressUnparseable" do
      expect{ @client.send(:check_response_status, "addressUnparseable") }.to raise_error("AddressUnparseable")
    end

    it "should raise an error with NoAddressParameter" do
      expect{ @client.send(:check_response_status, "noAddressParameter") }.to raise_error("NoAddressParameter")
    end

    it "should raise an error with MultipleStreetSegmentsFound" do
      expect{ @client.send(:check_response_status, "multipleStreetSegmentsFound") }.to raise_error("MultipleStreetSegmentsFound")
    end

    it "should raise an error with ElectionOver" do
      expect{ @client.send(:check_response_status, "electionOver") }.to raise_error("ElectionOver")
    end

    it "should raise an error with ElectionUnknown" do
      expect{ @client.send(:check_response_status, "electionUnknown") }.to raise_error("ElectionUnknown")
    end

    it "should raise an error with InternalLookupFailure" do
      expect{ @client.send(:check_response_status, "internalLookupFailure") }.to raise_error("InternalLookupFailure")
    end

    it "should not raise an error" do
      expect{ @client.send(:check_response_status, "success") }.to_not raise_error
    end
  end

  describe "official only" do
    it "should allowing toggling official_only" do
      expect(@client.official_only).to eq(false)
    end

    it "should allowing toggling official_only" do
      @client.official_only = true
      expect(@client.official_only).to eq(true)
    end

    it "should have client instead of class for official_only" do
      CivicAide.official_only = true
      @client.official_only = false
      expect(@client.official_only).to eq(false)
    end
  end

end