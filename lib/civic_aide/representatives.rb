module CivicAide
  class Representatives
    attr_reader :client, :include_offices

    def initialize(client)
      @client = client
      @include_offices = true
    end

    def at(address)
      response = client.post("/representatives/lookup", {includeOffices: @include_offices}, {:address => address})
      response.except!(:kind, :status)
    end

  end
end