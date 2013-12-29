# CivicAide

[![Gem Version](https://badge.fury.io/rb/civic_aide.png)](http://badge.fury.io/rb/civic_aide)
[![Build Status](https://travis-ci.org/tylerpearson/civic_aide.png?branch=master)](https://travis-ci.org/tylerpearson/civic_aide)

A (unofficial) Ruby wrapper to interact with the [Google Civic Information API](https://developers.google.com/civic-information/).

Currently the API only provides information for the United States.

## Installation

Add this line to your application's Gemfile:

    gem 'civic_aide'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install civic_aide

## Usage

### Setup

The Google Civic Information API requires an API key, so before you start grab a [server API key](https://developers.google.com/civic-information/docs/using_api) from the [Google Cloud Console](https://cloud.google.com/console#/project).

The current default API limits for the Google Civic Information API are 1/request/second/user and 25,000 requests/day.

### Response

All responses are wrapped in a [hashie](https://github.com/intridea/hashie) object that can be accessed in a number of ways. All methods have been rubyify'ed **but** those matching [Open Civic Data identifiers](https://github.com/opencivicdata/ocd-division-ids) (e.g. `ocd-division/country:us/state:nc/county:durham`).

Additionally, to avoid clashing with the [Array#zip Ruby method](http://apidock.com/ruby/Array/zip), any `zip` address fields in the API response have been renamed to `zip_code`.

### Configuration

```ruby
api_key = `ABCaSyD5aMsdmaXxHc7aiUyYuVXtCICV-y_PWnf5w`
client = CivicAide::Client.new(api_key)
```

Alternatively, the API key can be set with global configuration and the resources can be accessed directly.

```ruby
CivicAide.api_key = "ABCaSyD5aMsdmaXxHc7aiUyYuVXtCICV-y_PWnf5w"
CivicAide.elections.all
```

To [receive data that is only from official state sources](https://developers.google.com/civic-information/docs/us_v1/elections/voterInfoQuery), set `CivicPage.official_sources` to `true`. By default this is set to `false`.

```ruby
CivicAide.official_sources = true
# or
client.official_sources = true
```

## Resources

### [Elections](https://developers.google.com/civic-information/docs/us_v1/elections)

#### All elections

To fetch a list of all available elections and their ids.

```ruby
client.elections.all
```

##### Sample response

```ruby
{"elections"=>
  [{"id"=>"2000", "name"=>"VIP Test Election", "election_day"=>"2015-06-06"},
   {"id"=>"4000",
    "name"=>"U.S. 2012 General Election",
    "election_day"=>"2012-11-06"},
   {"id"=>"4001",
    "name"=>"Los Angeles City Primary",
    "election_day"=>"2013-03-05"},
   {"id"=>"4002",
    "name"=>"California Combined Special Elections",
    "election_day"=>"2013-03-12"},
   {"id"=>"4003",
    "name"=>"South Carolina HD-01 Special Primary",
    "election_day"=>"2013-03-19"},
   {"id"=>"4004",
    "name"=>"California Special Election SD-32",
    "election_day"=>"2013-05-14"},
   {"id"=>"4005",
    "name"=>"Los Angeles City Election",
    "election_day"=>"2013-05-21"},
   {"id"=>"4006",
    "name"=>"South Carolina HD-01",
    "election_day"=>"2013-05-07"},
   {"id"=>"4007", "name"=>"New Jersey Primary", "election_day"=>"2013-06-04"},
   {"id"=>"4008", "name"=>"Virginia Primary", "election_day"=>"2013-06-11"},
   {"id"=>"4009",
    "name"=>"Delaware Presidential Primary 2012",
    "election_day"=>"2013-09-01"},
   {"id"=>"4010",
    "name"=>"NYC 2013 Mayoral Primary",
    "election_day"=>"2013-09-10"},
   {"id"=>"4011",
    "name"=>"NYC 2013 Mayoral Primary Runoff",
    "election_day"=>"2013-10-01"},
   {"id"=>"4012",
    "name"=>"NJ 2013 U.S. Senate Special Election",
    "election_day"=>"2013-10-16"},
   {"id"=>"4013",
    "name"=>"NYC 2013 Mayoral Election",
    "election_day"=>"2013-11-05"},
   {"id"=>"4014", "name"=>"NJ State Election", "election_day"=>"2013-11-05"},
   {"id"=>"4015", "name"=>"VA State Election", "election_day"=>"2013-11-05"},
   {"id"=>"4016",
    "name"=>"MN 2013 Municipal General",
    "election_day"=>"2013-11-05"}]}
```

#### Find election info by address

After finding the id for the election you want, pass the election id and the voter's registered address. `election` is an alias for `elections`.

```ruby
client.election(4015).at('4910 Willet Drive, Annandale, VA 22003')
```

##### Sample Response

```ruby
{"election"=>
  {"id"=>"4015", "name"=>"VA State Election", "election_day"=>"2013-11-05"},
 "normalized_input"=>
  {"line1"=>"4910 willet dr",
   "city"=>"annandale",
   "state"=>"VA",
   "zip_code"=>"22003"},
 "contests"=>
  [{"type"=>"general",
    "special"=>"no",
    "office"=>"Governor",
    "district"=>{"name"=>"Statewide", "scope"=>"statewide"},
    "ballot_placement"=>"4",
    "candidates"=>
     [{"name"=>"Ken T. Cuccinelli II",
       "party"=>"Republican",
       "candidate_url"=>"http://www.cuccinelli.com",
       "phone"=>"8047863808",
       "email"=>"ken@cuccinelli.com"},
      {"name"=>"Robert C. Sarvis",
       "party"=>"Libertarian",
       "candidate_url"=>"http://www.robertsarvis.com",
       "email"=>"info@robertsarvis.com"},
      {"name"=>"Terry R. McAuliffe",
       "party"=>"Democrat",
       "candidate_url"=>"http://www.terrymcauliffe.com",
       "phone"=>"7038227604",
       "email"=>"info@terrymcauliffe.com"}],
    "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]},
   {"type"=>"general",
    "special"=>"no",
    "office"=>"Attorney General",
    "district"=>{"name"=>"Statewide", "scope"=>"statewide"},
    "ballot_placement"=>"6",
    "candidates"=>
     [{"name"=>"Mark D. Obenshain",
       "party"=>"Republican",
       "candidate_url"=>"http://www.markobenshain.com",
       "phone"=>"5404371451",
       "email"=>"campaign@markobenshain.com"},
      {"name"=>"Mark R. Herring",
       "party"=>"Democrat",
       "candidate_url"=>"http://www.herringforag.com",
       "phone"=>"7036699090",
       "email"=>"kevin@herringforag.com"}],
    "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]},
   {"type"=>"general",
    "special"=>"no",
    "office"=>"Sheriff",
    "district"=>{"name"=>"FAIRFAX COUNTY"},
    "ballot_placement"=>"11",
    "candidates"=>
     [{"name"=>"Stacey Ann Kincaid",
       "party"=>"Democrat",
       "candidate_url"=>"http://staceykincaid.com",
       "phone"=>"7039381658",
       "email"=>"Kincaidforsheriff@gmail.com"},
      {"name"=>"Christopher F. DeCarlo",
       "party"=>"Independent",
       "candidate_url"=>"http://www.honestyandethics.com",
       "phone"=>"7035736160",
       "email"=>"cdecarlo@fairfaxpropane.com"},
      {"name"=>"Bryan A. /B. A./ Wolfe",
       "party"=>"Republican",
       "candidate_url"=>"http://www.wolfeforsheriff.com",
       "phone"=>"7035436360",
       "email"=>"fairfaxwolfe@yahoo.com"},
      {"name"=>"Robert A. Rivera",
       "party"=>"Independent",
       "phone"=>"7039783034",
       "email"=>"riveraforsheriff@gmail.com"}],
    "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]},
   {"type"=>"Referendum",
    "special"=>"no",
    "office"=>"School Bonds",
    "district"=>{"name"=>"FAIRFAX COUNTY", "id"=>"59"},
    "ballot_placement"=>"9999",
    "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]}],
 "state"=>
  [{"name"=>"Virginia",
    "election_administration_body"=>
     {"name"=>"State Board of Elections",
      "election_info_url"=>"http://www.sbe.virginia.gov/",
      "election_registration_url"=>"https://www.vote.virginia.gov/",
      "election_registration_confirmation_url"=>
       "https://www.vote.virginia.gov/",
      "absentee_voting_info_url"=>
       "http://www.sbe.virginia.gov/absenteevoting.html",
      "voting_location_finder_url"=>"https://www.vote.virginia.gov/",
      "ballot_info_url"=>"https://www.vote.virginia.gov/",
      "election_rules_url"=>"http://www.sbe.virginia.gov/",
      "physical_address"=>
       {"location_name"=>"State Board of Elections",
        "line1"=>"Washington Building First Floor",
        "line2"=>"1100 Bank Street",
        "city"=>"Richmond",
        "state"=>"VA",
        "zip_code"=>"23219"}},
    "local_jurisdiction"=>
     {"name"=>"FAIRFAX COUNTY",
      "election_administration_body"=>
       {"name"=>"FAIRFAX COUNTY",
        "election_info_url"=>"http://www.fairfaxcounty.gov/elections",
        "election_registration_url"=>"http://www.vote.virginia.gov",
        "election_registration_confirmation_url"=>
         "http://www.vote.virginia.gov",
        "absentee_voting_info_url"=>"http://www.vote.virginia.gov",
        "voting_location_finder_url"=>"http://www.vote.virginia.gov",
        "ballot_info_url"=>"http://www.vote.virginia.gov",
        "election_rules_url"=>"http://www.vote.virginia.gov",
        "hours_of_operation"=>
         "8:00 a.m. to 4:30 p.m Monday-Wednesday and Friday and 8:00 a.m. to 7:00 p.m. Thursday",
        "physical_address"=>
         {"location_name"=>"FAIRFAX COUNTY",
          "line1"=>"OFFICE OF ELECTIONS",
          "line2"=>"12000 GOVERNMENT CENTER PKWY",
          "line3"=>"SUITE 323",
          "city"=>"FAIRFAX",
          "state"=>"VA",
          "zip_code"=>"22035-0081"},
        "election_officials"=>
         [{"name"=>"CAMERON P. QUINN",
           "title"=>"General Registrar Physical",
           "office_phone_number"=>"7033244715",
           "email_address"=>"cameronquinn@fairfaxcounty.gov"}]},
      "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]},
    "sources"=>[{"name"=>"Voting Information Project", "official"=>true}]}]}
```

### [Representatives](https://developers.google.com/civic-information/docs/us_v1/representatives/representativeInfoQuery)

Retrieve political geography and representative information based on an address.

```ruby
client.representatives.at('118 E. Main St. Carrboro, NC 27510')
```

##### Response (shortened some to save space)

```ruby
{"normalized_input"=>
  {"line1"=>"118 e main st",
   "city"=>"carrboro",
   "state"=>"NC",
   "zip_code"=>"27510"},
 "divisions"=>
  {"ocd-division/country:us/state:nc/cd:4"=>
    {"name"=>"North Carolina's 4th congressional district",
     "scope"=>"congressional",
     "office_ids"=>["O0"]},
   "ocd-division/country:us/state:nc"=>
    {"name"=>"North Carolina",
     "scope"=>"statewide",
     "office_ids"=>
      ["O1", "O2", "O3", "O4", "O5", "O6", "O7", "O8", "O9", "Oa", "Ob"]},
   "ocd-division/country:us/state:nc/place:carrboro"=>
    {"name"=>"Carrboro town", "scope"=>"citywide"},
   "ocd-division/country:us"=>
    {"name"=>"United States", "scope"=>"national", "office_ids"=>["Oc", "Od"]},
   "ocd-division/country:us/state:nc/county:orange"=>
    {"name"=>"Orange County",
     "scope"=>"countywide",
     "office_ids"=>["Oe", "Of", "O10", "O11", "O12"]}},
 "offices"=>
  {"o0"=>
    {"name"=>"United States House of Representatives NC-04",
     "level"=>"federal",
     "official_ids"=>["P0"]},
   "o1"=>{"name"=>"Governor", "level"=>"state", "official_ids"=>["P1"]},
   "o2"=>{"name"=>"State Auditor", "level"=>"state", "official_ids"=>["P2"]},
   "o3"=>{"name"=>"State Treasurer", "level"=>"state", "official_ids"=>["P3"]},
   "o4"=>
    {"name"=>"Attorney General", "level"=>"state", "official_ids"=>["P4"]},
   "o5"=>
    {"name"=>"Secretary of State", "level"=>"state", "official_ids"=>["P5"]},
   "o6"=>
    {"name"=>"Lieutenant Governor", "level"=>"state", "official_ids"=>["P6"]},
   "o7"=>
    {"name"=>"United States Senate",
     "level"=>"federal",
     "official_ids"=>["P7", "P8"]},
 "officials"=>
  {"p4"=>
    {"name"=>"Roy Cooper",
     "address"=>
      [{"line1"=>"9001 Mail Service Center",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27699"}],
     "phones"=>["(919) 716-6400"],
     "urls"=>["http://www.ncdoj.gov/"],
     "channels"=>
      [{"type"=>"Facebook", "id"=>"157759274279900"},
       {"type"=>"Twitter", "id"=>"NCAGO"}]},
   "p5"=>
    {"name"=>"Elaine Marshall",
     "address"=>
      [{"line1"=>"NC Secretary of State PO Box 29622",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27626"}],
     "phones"=>["(919) 807-2000"],
     "urls"=>["http://www.sosnc.com/"]},
   "p6"=>
    {"name"=>"Dan Forest",
     "address"=>
      [{"line1"=>"20401 Mail Service Center",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27699"}],
     "party"=>"Republican",
     "phones"=>["(919) 733-7350"],
     "urls"=>["http://www.ltgov.state.nc.us/"],
     "emails"=>["lt.gov@nc.gov"],
     "channels"=>
      [{"type"=>"Facebook", "id"=>"DanForestNC"},
       {"type"=>"Twitter", "id"=>"DanForestNC"}]},
   "p7"=>
    {"name"=>"Kay R. Hagan",
     "address"=>
      [{"line1"=>"521 Dirksen Senate Office Building",
        "city"=>"washington",
        "state"=>"DC",
        "zip_code"=>"20510"}],
     "party"=>"Democratic",
     "phones"=>["(202) 224-6342"],
     "urls"=>["http://www.hagan.senate.gov/"],
     "photo_url"=>
      "http://www.senate.gov/general/resources/graphic/medium/Hagan_200.jpg",
     "emails"=>["Senator_Hagan@hagan.senate.gov"],
     "channels"=>
      [{"type"=>"Facebook", "id"=>"SenatorHagan"},
       {"type"=>"Twitter", "id"=>"SenatorHagan"},
       {"type"=>"YouTube", "id"=>"SenatorHagan"}]},
   "p8"=>
    {"name"=>"Richard Burr",
     "address"=>
      [{"line1"=>"217 Russell Senate Office Building",
        "city"=>"washington",
        "state"=>"DC",
        "zip_code"=>"20510"}],
     "party"=>"Republican",
     "phones"=>["(202) 224-3154"],
     "urls"=>["http://www.burr.senate.gov/public/"],
     "photo_url"=>"http://bioguide.congress.gov/bioguide/photo/B/B001135.jpg",
     "channels"=>
      [{"type"=>"Facebook", "id"=>"SenatorRichardBurr"},
       {"type"=>"Twitter", "id"=>"senatorburr"},
       {"type"=>"YouTube", "id"=>"SenatorRichardBurr"}]},
   "p9"=>
    {"name"=>"Cherie Berry",
     "address"=>
      [{"line1"=>"NC Department of Labor 1101 Mail Service Center",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27699"}],
     "phones"=>["(919) 807-2796"],
     "urls"=>["http://www.nclabor.com/"],
     "emails"=>["Commissioners.Office@labor.nc.gov"]},
   "p10"=>
    {"name"=>"Wayne Goodwin",
     "urls"=>["http://www.ncdoi.com/"],
     "emails"=>["Commissioner@ncdoi.gov"],
     "channels"=>
      [{"type"=>"Facebook", "id"=>"ncdoi"},
       {"type"=>"Twitter", "id"=>"NCInsuranceDept"}]},
   "p11"=>
    {"name"=>"Steve Troxler",
     "address"=>
      [{"line1"=>"1001 Mail Service Center",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27699"}],
     "phones"=>["(919) 707-3021"],
     "urls"=>["http://www.ncagr.gov/"]},
   "p12"=>
    {"name"=>"June Atkinson",
     "address"=>
      [{"line1"=>
         "Office of the State Superintendent NC Education Building 6301 Mail Service Center",
        "city"=>"raleigh",
        "state"=>"NC",
        "zip_code"=>"27699"}],
     "phones"=>["(919) 807-3430"],
     "urls"=>["http://www.ncpublicschools.org/statesuperintendent/"],
     "emails"=>["june.atkinson@dpi.nc.gov"]},
   "p13"=>
    {"name"=>"Barack Hussein Obama II",
     "address"=>
      [{"line1"=>"The White House",
        "line2"=>"1600 Pennsylvania Avenue NW",
        "line3"=>"",
        "city"=>"Washington",
        "state"=>"DC",
        "zip_code"=>"20500"}],
     "party"=>"Democrat",
     "phones"=>["(202) 456-1111", "(202) 456-1414"],
     "urls"=>
      ["http://www.whitehouse.gov/administration/president_obama/",
       "http://www.barackobama.com/index.php"],
     "photo_url"=>
      "http://www.whitehouse.gov/sites/default/files/imagecache/admin_official_lowres/administration-official/ao_image/president_official_portrait_hires.jpg",
     "channels"=>
      [{"type"=>"GooglePlus", "id"=>"110031535020051778989"},
       {"type"=>"YouTube", "id"=>"barackobama"},
       {"type"=>"Twitter", "id"=>"barackobama"},
       {"type"=>"Facebook", "id"=>"barackobama"}]},
   "p14"=>
    {"name"=>"Joseph (Joe) Robinette Biden Jr.",
     "address"=>
      [{"line1"=>"The White House",
        "line2"=>"1600 Pennsylvania Avenue NW",
        "line3"=>"",
        "city"=>"Washington",
        "state"=>"DC",
        "zip_code"=>"20500"}],
     "party"=>"Democrat",
     "urls"=>["http://www.whitehouse.gov/administration/vice-president-biden"],
     "photo_url"=>
      "http://www.whitehouse.gov/sites/default/files/imagecache/admin_official_lowres/administration-official/ao_image/vp_portrait.jpeg",
     "channels"=>
      [{"type"=>"Twitter", "id"=>"JoeBiden"},
       {"type"=>"Facebook", "id"=>"joebiden"},
       {"type"=>"Twitter", "id"=>"VP"}]}}
```

## Improvements

If you find an error with the data, please [let Google know](https://docs.google.com/forms/d/1bEqKzq5y9mnVBaReJP_o7fH6xkc4T484UdEbvJNxZ9c/viewform).

If you find an error with the gem, please add an issue. Feedback is appreciated!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
