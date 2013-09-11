# -*- encoding: utf-8 -*-

require 'centzy_common'

require 'smartystreets/base_json_object'

module SmartyStreets

  # Represents a request for a zipcode.
  #
  # @author Peter Edge <peter@centzy.com>
  class ZipcodeRequest < BaseJsonObject

    attr_reader :city
    attr_reader :state
    attr_reader :zipcode

    def initialize(hash)
      super(hash)
      @city = get_optional_string(hash, :city)
      @state = get_optional_string(hash, :state)
      @zipcode = get_optional_string(hash, :zipcode)

      check_argument(!(!@city && @state && @zipcode))
    end

    def to_json(*a)
      hash = Hash.new
      hash[:city] = city if city
      hash[:state] = state if state
      hash[:zipcode] = zipcode if zipcode
      hash.to_json(*a)
    end
  end
end
