require 'spec_helper'

describe CivicAide::Elections do

  before do
    @client = CivicAide::Client.new("AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY")
  end

  describe "get all elections" do

    let(:info) { @client.elections.all }

    before do
      VCR.insert_cassette 'elections/all', :record => :new_episodes
      @election = info.elections.first
    end

    after do
      VCR.eject_cassette
    end

    it "must parse the response from JSON to Hash" do
      expect(info).to be_a Hash
    end

    it "should have elections" do
      expect(info).to respond_to(:elections)
    end

    it "should have multiple elections" do
      info.elections.should_not be_empty
    end

    it "should have an id" do
      expect(@election.id).to eq("2000")
    end

    it "should have a name" do
      expect(@election.name).to eq("VIP Test Election")
    end

    it "should have an election day" do
      expect(@election.election_day).to eq("2015-06-06")
    end

  end

  describe "get info for specific election" do

    let(:info) { @client.elections(4015).at('4910 Willet Drive, Annandale, VA 22003') }

    before do
      VCR.insert_cassette 'elections/single', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must parse the response from JSON to Hash" do
      expect(info).to be_a Hash
    end

    it "should have an election" do
      expect(info.election).to be_a Hash
    end

    it "should have an election id" do
      expect(info.election.id).to eq("4015")
    end

    it "should have an election name" do
      expect(info.election.name).to eq("VA State Election")
    end

    it "should have an election day" do
      expect(info.election.election_day).to eq("2013-11-05")
    end

    it "should have normalized input" do
      expect(info).to respond_to(:normalized_input)
    end

    it "should have normalized input hash" do
      expect(info.normalized_input).to be_a Hash
    end

    it "should have normalized input line 1" do
      expect(info.normalized_input.line1).to eq("4910 willet dr")
    end

    it "should have normalized input city" do
      expect(info.normalized_input.city).to eq("annandale")
    end

    it "should have normalized input state" do
      expect(info.normalized_input.state).to eq("VA")
    end

    it "should have normalized input zip" do
      expect(info.normalized_input.zip_code).to eq("22003")
    end

    it "should have contests" do
      expect(info).to respond_to(:contests)
    end

    it "should have contests as array" do
      expect(info.contests).to be_a Array
    end

    it "should have candidates" do
      expect(info.contests[0]).to respond_to(:candidates)
    end

    it "should have candidates array" do
      expect(info.contests[0].candidates).to be_a Array
    end

    it "should have sources" do
      expect(info.contests[0]).to respond_to(:sources)
    end

    it "should have sources array" do
      expect(info.contests[0].sources).to be_a Array
    end

  end

end