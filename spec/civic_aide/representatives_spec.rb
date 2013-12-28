require 'spec_helper'

describe CivicAide::Representatives do

  before do
    @client = CivicAide::Client.new("AIzaSyDWJSisG_4Azd6nVJTU5gdKPiKKTCovupY")
  end

  describe "get info for specific election" do

    let(:info) { @client.representatives.at('320 E Chapel Hill St, Durham NC, 27701') }

    before do
      VCR.insert_cassette 'representatives/single', :record => :new_episodes
    end

    after do
      VCR.eject_cassette
    end

    it "must parse the response from JSON to Hash" do
      expect(info).to be_a Hash
    end

    it "must remove kind" do
      expect(info).to_not respond_to(:kind)
    end

    it "should have normalized input" do
      expect(info).to respond_to(:normalized_input)
    end

    it "should have normalized input hash" do
      expect(info.normalized_input).to be_a Hash
    end

    it "should have normalized input line 1" do
      expect(info.normalized_input.line1).to eq("320 e chapel hill st")
    end

    it "should have normalized input city" do
      expect(info.normalized_input.city).to eq("durham")
    end

    it "should have normalized input state" do
      expect(info.normalized_input.state).to eq("NC")
    end

    it "should have normalized input zip" do
      expect(info.normalized_input.zip_code).to eq("27701")
    end

    it "should respond to divisions" do
      expect(info).to respond_to(:divisions)
    end

    describe "individual division area" do

      let(:area) { info.divisions['ocd-division/country:us/state:nc/county:durham'] }

      it "should have name" do
        expect(area.name).to eq("Durham County")
      end

      it "should have scope" do
        expect(area.scope).to eq("countywide")
      end

      it "should have office ids" do
        expect(area.office_ids).to be_a Array
      end

      it "should have division areas" do
        expect(area).to be_a Hash
      end

    end

    describe "individual offices" do

      let(:office) { info.offices.o1 }

      it "should have name" do
        expect(office.name).to eq("Clerk of Courts")
      end

      it "should have level" do
        expect(office.level).to eq("county")
      end

      it "should have official ids" do
        expect(office.official_ids).to be_a Array
      end

    end

    describe "individual official" do

      let(:official) { info.officials.p9 }

      it "should have officials" do
        expect(info).to respond_to(:officials)
      end

      it "should have name" do
        expect(official.name).to eq("Pat McCrory")
      end

      it "should have party" do
        expect(official.party).to eq("Republican")
      end

      it "should have photo url" do
        expect(official.photo_url).to eq("http://www.governor.state.nc.us/sites/all/themes/govpat/images/GovPatMcCrory.jpg")
      end

      it "should have addresses" do
        expect(official.address).to be_a Array
      end

      it "should have phones" do
        expect(official.phones).to be_a Array
      end

      it "should have website urls" do
        expect(official.urls).to be_a Array
      end

      it "should have social media channels" do
        expect(official.channels).to be_a Array
      end

    end

  end

end