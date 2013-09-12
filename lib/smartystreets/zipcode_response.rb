# -*- encoding: utf-8 -*-

require 'centzy_common'

require 'smartystreets/base_json_object'

module SmartyStreets

  # Represents a response for a zipcode.
  #
  # @author Peter Edge <peter@centzy.com>
  class ZipcodeResponse < BaseJsonObject

    module ErrorStatus
      BLANK = "blank"
      INVALID_STATE = "invalid_state"
      INVALID_CITY = "invalid_city"
      INVALID_ZIPCODE = "invalid_zipcode"
      CONFLICT = "conflict"
    end

    def initialize(hash)
      super(hash)

      error_status = get_optional_string(hash, :status)
      if error_status
        @error_status = case error_status
        when ErrorStatus::BLANK then error_status
        when ErrorStatus::INVALID_STATE then error_status
        when ErrorStatus::INVALID_CITY then error_status
        when ErrorStatus::INVALID_ZIPCODE then error_status
        when ErrorStatus::CONFLICT then error_status
        else raise ArgumentError.new("Unrecognized error status: #{error_status}")
        end
      else
        city_states = get_optional_array(hash, :city_states)
        zipcodes = get_optional_array(hash, :zipcodes)
        @city_states = city_states.map { |city_state| CityState.new(city_state) } if city_states
        @zipcodes = zipcodes.map { |zipcode| ZipCode.new(zipcode) } if zipcodes
      end
    end

    def error?
      error_status != nil
    end

    def error_status
      @error_status
    end

    def city_states
      raise StandardError.new("Error status was #{error_status}") if error?
      @city_states
    end

    def zipcodes
      raise StandardError.new("Error status was #{error_status}") if error?
      @zipcodes
    end

    class CityState < BaseJsonObject

      attr_reader :city
      attr_reader :state_abbreviation
      attr_reader :state

      def initialize(hash)
        super(hash)
        @city = get_optional_string(hash, :city)
        @state_abbreviation = get_optional_string(hash, :state_abbreviation)
        @state = get_optional_string(hash, :state)
      end
    end

    class ZipCode < BaseJsonObject

      attr_reader :zipcode
      attr_reader :zipcode_type
      attr_reader :county_fips
      attr_reader :county_name
      attr_reader :latitude
      attr_reader :longitude

      def initialize(hash)
        super(hash)
        @zipcode = get_optional_string(hash, :zipcode)
        @zipcode_type = get_optional_string(hash, :zipcode_type)
        @county_fips = get_optional_string(hash, :county_fips)
        @county_name = get_optional_string(hash, :county_name)
        @latitude = get_optional_float(hash, :latitude)
        @longitude = get_optional_float(hash, :longitude)
      end
    end
  end
end
