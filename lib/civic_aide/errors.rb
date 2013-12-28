class APIError < StandardError; end

class APIKeyNotSet < StandardError
  def initialize(msg = "Missing a required Google API key.")
    super
  end
end

class ElectionIdMissing < StandardError
  def initialize(msg = "Missing a required election id.")
    super
  end
end

class NoStreetSegmentFound < APIError
  def initialize(msg = "The API currently has no information about what electoral precinct and/or district this address belongs to. It may be that we are still sourcing/processing new data, or that there are no voters who have registered to vote at this address.")
    super
  end
end

class AddressUnparseable < APIError
  def initialize(msg = "The requested address is not formatted correctly or cannot be geocoded (i.e. the Google Maps API does not know anything about this address).")
    super
  end
end

class NoAddressParameter < APIError
  def initialize(msg = "No address was provided.")
    super
  end
end

class MultipleStreetSegmentsFound < APIError
  def initialize(msg = "The API cannot find information for the specified address, but it has information about nearby addresses. The user should contact their election official for more information.")
    super
  end
end

class ElectionOver < APIError
  def initialize(msg = "The requested election is over. API results for the election are no longer available. Make an electionQuery to find an id for an upcoming election.")
    super
  end
end

class ElectionUnknown < APIError
  def initialize(msg = "The requested election id is invalid. Make an electionQuery to find a valid id.")
    super
  end
end

class InternalLookupFailure < APIError
  def initialize(msg = "An unspecified error occurred processing the request.")
    super
  end
end

