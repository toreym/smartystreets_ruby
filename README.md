# SmartyStreets

[![Build Status](https://travis-ci.org/centzy/smartystreets.png?branch=master)](https://travis-ci.org/centzy/smartystreets)

SmartyStreets API Wrapper for Ruby.

Wraps both the Street Address API and Zipcode API.

http://smartystreets.com/  
http://smartystreets.com/kb/liveaddress-api/

## Installation

Add this line to your application's Gemfile:

    gem 'smartystreets'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smartystreets

## Usage

You must have a valid auth-id and auth-token from SmartyStreets.

```ruby
SmartyStreets.set_auth("AUTH_ID", "AUTH_TOKEN")

street_address_responses = SmartyStreets::StreetAddressApi.call(
  SmartyStreets::StreetAddressRequest.new(
    :input_id => "1",
    :street => "222 Broadway Fl 20",
    :city => "New York",
    :state => "NY",
    :zipcode => "10038"
  ),
  SmartyStreets::StreetAddressRequest.new(
    :input_id => "2",
    :street => "175 Varick St Fl 4",
    :city => "New York",
    :state => "NY",
    :zipcode => "10014"
  )
)

# [#<SmartyStreets::StreetAddressResponse:0x007fb5c5198c28 @input_id="1", @input_index=0, @candidate_index=0, @addressee=nil, @delivery_line_1="222 Broadway Fl 20", @delivery_line_2=nil, @last_line="New York NY 10038-2510", @delivery_point_barcode="100382510992", @components=#<SmartyStreets::StreetAddressResponse::Components:0x007fb5c51a2f48 @urbanization=nil, @primary_number="222", @street_name="Broadway", @street_predirection=nil, @street_postdirection=nil, @street_suffix=nil, @secondary_number="20", @secondary_designator="Fl", @extra_secondary_number=nil, @extra_secondary_designator=nil, @pmb_designator=nil, @pmb_number=nil, @city_name="New York", @default_city_name=nil, @state_abbreviation="NY", @zipcode="10038", @plus4_code="2510", @delivery_point="99", @delivery_point_check_digit="2">, @metadata=#<SmartyStreets::StreetAddressResponse::Metadata:0x007fb5c51a1af8 @record_type="H", @zip_type="Standard", @county_fips="36061", @county_name="New York", @carrier_route="C031", @congressional_district="10", @building_default_indicator="Y", @rdi="Commercial", @elot_sequence="0004", @elot_sort="A", @latitude=40.71035, @longitude=-74.00909, @precision="Zip7">, @analysis=#<SmartyStreets::StreetAddressResponse::Analysis:0x007fb5c51a0220 @dpv_match_code="S", @dpv_footnotes="AACC", @dpv_cmra="N", @dvp_vacant=nil, @active="Y", @ews_match=nil, @footnotes="S#", @lacslink_code=nil, @lacslink_indicator=nil, @suitelink_match=nil>>, #<SmartyStreets::StreetAddressResponse:0x007fb5c51b3618 @input_id="2", @input_index=1, @candidate_index=0, @addressee=nil, @delivery_line_1="175 Varick St Fl 4", @delivery_line_2=nil, @last_line="New York NY 10014-7412", @delivery_point_barcode="100147412046", @components=#<SmartyStreets::StreetAddressResponse::Components:0x007fb5c51bb098 @urbanization=nil, @primary_number="175", @street_name="Varick", @street_predirection=nil, @street_postdirection=nil, @street_suffix="St", @secondary_number="4", @secondary_designator="Fl", @extra_secondary_number=nil, @extra_secondary_designator=nil, @pmb_designator=nil, @pmb_number=nil, @city_name="New York", @default_city_name=nil, @state_abbreviation="NY", @zipcode="10014", @plus4_code="7412", @delivery_point="04", @delivery_point_check_digit="6">, @metadata=#<SmartyStreets::StreetAddressResponse::Metadata:0x007fb5c51c1fd8 @record_type="H", @zip_type="Standard", @county_fips="36061", @county_name="New York", @carrier_route="C036", @congressional_district="10", @building_default_indicator=nil, @rdi="Commercial", @elot_sequence="0121", @elot_sort="A", @latitude=40.72751, @longitude=-74.00548, @precision="Zip9">, @analysis=#<SmartyStreets::StreetAddressResponse::Analysis:0x007fb5c51cbf60 @dpv_match_code="Y", @dpv_footnotes="AABB", @dpv_cmra="N", @dvp_vacant=nil, @active="Y", @ews_match=nil, @footnotes=nil, @lacslink_code=nil, @lacslink_indicator=nil, @suitelink_match=nil>>]

zipcode_responses = SmartyStreets::ZipcodeApi.call(
  SmartyStreets::ZipcodeRequest.new(
    :city => "New York",
    :state => "NY",
    :zipcode => "10038"
  ),
  SmartyStreets::ZipcodeRequest.new(
    :zipcode => "10014"
  ),
  SmartyStreets::ZipcodeRequest.new(
    :zipcode => "aaaaa"
  )
)

# [#<SmartyStreets::ZipcodeResponse:0x007fb5c51f22a0 @city_states=[#<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51f1c10 @city="New York", @state_abbreviation=nil, @state="New York">], @zipcodes=[#<SmartyStreets::ZipcodeResponse::ZipCode:0x007fb5c51f1508 @zipcode="10038", @zipcode_type="S", @county_fips="36061", @county_name="New York", @latitude=40.709145, @longitude=-74.004713>]>, #<SmartyStreets::ZipcodeResponse:0x007fb5c51f0798 @city_states=[#<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51fbf30 @city="New York", @state_abbreviation=nil, @state="New York">, #<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51fb468 @city="Manhattan", @state_abbreviation=nil, @state="New York">, #<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51fad38 @city="New York City", @state_abbreviation=nil, @state="New York">, #<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51fa5e0 @city="Ny", @state_abbreviation=nil, @state="New York">, #<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51f9e38 @city="Ny City", @state_abbreviation=nil, @state="New York">, #<SmartyStreets::ZipcodeResponse::CityState:0x007fb5c51f9780 @city="Nyc", @state_abbreviation=nil, @state="New York">], @zipcodes=[#<SmartyStreets::ZipcodeResponse::ZipCode:0x007fb5c51f90f0 @zipcode="10014", @zipcode_type="S", @county_fips="36061", @county_name="New York", @latitude=40.73378, @longitude=-74.00484>]>, #<SmartyStreets::ZipcodeResponse:0x007fb5c51f81f0 @error_status="invalid_zipcode">]
```

Written for Locality  
http://www.locality.com

## Authors

Peter Edge  
peter@locality.com  
http://github.com/peter-edge

## License

MIT
