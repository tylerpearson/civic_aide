require 'spec_helper'

describe "Error" do

  it "matches the error message" do
    expect { raise APIKeyNotSet}.to raise_error(APIKeyNotSet, 'Missing a required Google API key.')
    expect { raise ElectionIdMissing}.to raise_error(ElectionIdMissing, 'Missing a required election id.')
    expect { raise NoStreetSegmentFound}.to raise_error(NoStreetSegmentFound, 'The API currently has no information about what electoral precinct and/or district this address belongs to. It may be that we are still sourcing/processing new data, or that there are no voters who have registered to vote at this address.')
    expect { raise AddressUnparseable}.to raise_error(AddressUnparseable, 'The requested address is not formatted correctly or cannot be geocoded (i.e. the Google Maps API does not know anything about this address).')
    expect { raise NoAddressParameter}.to raise_error(NoAddressParameter, 'No address was provided.')
    expect { raise MultipleStreetSegmentsFound}.to raise_error(MultipleStreetSegmentsFound, 'The API cannot find information for the specified address, but it has information about nearby addresses. The user should contact their election official for more information.')
    expect { raise ElectionOver}.to raise_error(ElectionOver, 'The requested election is over. API results for the election are no longer available. Make an electionQuery to find an id for an upcoming election.')
    expect { raise ElectionUnknown}.to raise_error(ElectionUnknown, 'The requested election id is invalid. Make an electionQuery to find a valid id.')
    expect { raise InternalLookupFailure}.to raise_error(InternalLookupFailure, 'An unspecified error occurred processing the request.')
  end

end

describe APIError do
  it { should be_kind_of(StandardError) }
end