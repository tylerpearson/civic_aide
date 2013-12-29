module CivicAide
  class Elections
    attr_reader :client, :election_id

    def initialize(client, election_id=nil)
      @client = client
      @election_id = election_id
    end

    def all
      response = client.get('/elections')
      response.except!(:kind)
    end

    def at(address)
      raise ElectionIdMissing, "Missing a required election id" if @election_id.nil?
      response = client.post("/voterinfo/#{election_id}/lookup", {officialOnly: @client.official_only}, {address: address})
      response.except!(:kind, :status)
    end

  end
end