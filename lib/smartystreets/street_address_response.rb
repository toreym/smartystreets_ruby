# -*- encoding: utf-8 -*-

require 'centzy_common'

require 'smartystreets/base_json_object'

module SmartyStreets

  # Represents a response for a street address.
  #
  # @author Peter Edge <peter@centzy.com>
  class StreetAddressResponse < BaseJsonObject

    attr_reader :input_index
    attr_reader :candidate_index
    attr_reader :addressee
    attr_reader :delivery_line_1
    attr_reader :delivery_line_2
    attr_reader :last_line
    attr_reader :delivery_point_barcode
    attr_reader :components
    attr_reader :metadata
    attr_reader :analysis

    def initialize(hash)
      super(hash)
      @input_index = get_optional_string(hash, :input_index)
      @candidate_index = get_optional_string(hash, :candidate_index)
      @addressee = get_optional_string(hash, :addressee)
      @delivery_line_1 = get_optional_string(hash, :delivery_line_1)
      @delivery_line_2 = get_optional_string(hash, :delivery_line_2)
      @last_line = get_optional_string(hash, :last_line)
      @delivery_point_barcode = get_optional_string(hash, :delivery_point_barcode)
      
      components = get_optional_hash(hash, :components)
      metadata = get_optional_hash(hash, :metadata)
      analysis = get_optional_hash(hash, :analysis)

      @components = Components.new(components) if components
      @metadata = Metadata.new(metadata) if metadata
      @analysis = Analysis.new(analysis) if analysis
    end

    class Components < BaseJsonObject

      attr_reader :primary_number
      attr_reader :street_name
      attr_reader :street_suffix
      attr_reader :city_name
      attr_reader :state_abbreviation
      attr_reader :zipcode
      attr_reader :plus4_code
      attr_reader :delivery_point
      attr_reader :delivery_point_check_digit

      def initialize(hash)
        super(hash)
        @primary_number = get_optional(hash, :primary_number)
        @street_name = get_optional(hash, :street_name)
        @street_suffix = get_optional(hash, :street_suffix)
        @city_name = get_optional(hash, :city_name)
        @state_abbreviation = get_optional(hash, :state_abbreviation)
        @zipcode = get_optional(hash, :zipcode)
        @plus4_code = get_optional(hash, :plus4_code)
        @delivery_point = get_optional(hash, :delivery_point)
        @delivery_point_check_digit = get_optional(hash, :delivery_point_check_digit)
      end
    end

    class Metadata < BaseJsonObject

      attr_reader :record_type
      attr_reader :county_fips
      attr_reader :county_name
      attr_reader :carrier_route
      attr_reader :congressional_district
      attr_reader :rdi
      attr_reader :latitude
      attr_reader :longitude
      attr_reader :precision

      def initialize(hash)
        super(hash)
        @record_type = get_optional(hash, :record_type)
        @county_fips = get_optional(hash, :county_fips)
        @county_name = get_optional(hash, :county_name)
        @carrier_route = get_optional(hash, :carrier_route)
        @congressional_district = get_optional(hash, :congressional_district)
        @rdi = get_optional(hash, :rdi)
        @latitude = get_optional(hash, :latitude)
        @longitude = get_optional(hash, :longitude)
        @precision = get_optional(hash, :precision)
      end
    end

    class Analysis < BaseJsonObject

      attr_reader :dpv_match_code
      attr_reader :dpv_footnotes
      attr_reader :dpv_cmrra
      attr_reader :dvp_vacant
      attr_reader :active

      def initialize(hash)
        super(hash)
        @dpv_match_code = get_optional(hash, :dpv_match_code)
        @dpv_footnotes = get_optional(hash, :dpv_footnotes)
        @dpv_cmrra = get_optional(hash, :dpv_cmrra)
        @dvp_vacant = get_optional(hash, :dvp_vacant)
        @active = get_optional(hash, :active)
      end
    end
  end
end
