require 'spec_helper'

describe CivicAide::Client do

  before do
    @client = CivicAide::Client.new("AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY")
  end

  describe '.new' do
    it 'raises an error with no API key' do
      expect{ CivicAide::Client.new }.to raise_error(APIKeyNotSet)
    end

    it "doesn't raise an error with class API key set" do
      CivicAide.api_key = "AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY"
      expect{ CivicAide::Client.new }.to_not raise_error
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
      @client.send(:default_query).should == {:key => @client.api_key, :prettyPrint => false}
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

end