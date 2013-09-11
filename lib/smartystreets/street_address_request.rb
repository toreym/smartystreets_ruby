# -*- encoding: utf-8 -*-

require 'centzy_common'

module SmartyStreets

  # Represents a request for a street address.
  #
  # @author Peter Edge <peter@centzy.com>
  class StreetAddressRequest
    include CentzyCommon::Preconditions

    attr_reader :input_id
    attr_reader :street
    attr_reader :street2
    attr_reader :secondary
    attr_reader :city
    attr_reader :state
    attr_reader :zipcode
    attr_reader :lastline
    attr_reader :addressee
    attr_reader :urbanization

    def initialize(hash)
      check_hash_key_types(hash, Symbol)
      check_hash_value_types(hash, String)

      @input_id = get_optional(hash, :input_id)
      @street = get_required(hash, :street)
      @street2 = get_optional(hash, :street2)
      @secondary = get_optional(hash, :secondary)
      @city = get_optional(hash, :city)
      @state = get_optional(hash, :state)
      @zipcode = get_optional(hash, :zipcode)
      @lastline = get_optional(hash, :lastline)
      @urbanization = get_optional(hash, :urbanization)
    end

    def to_json(*a)
      hash = Hash.new
      hash[:input_id] = input_id if input_id
      hash[:street] = street if street
      hash[:street2] = street2 if street2
      hash[:secondary] = secondary if secondary
      hash[:city] = city if city
      hash[:state] = state if state
      hash[:zipcode] = zipcode if zipcode
      hash[:lastline] = lastline if lastline
      hash[:addressee] = addressee if addressee
      hash[:urbanization] = urbanization if urbanization
      hash[:candidates] = SmartyStreets.candidates
      hash.to_json(*a)
    end

    private

    def get_optional(hash, key)
      hash.has_key?(key) ? (hash[key].empty? ? nil : hash[key]) : nil
    end

    def get_required(hash, key)
      check_argument(hash.has_key?(key))
      check_argument(!hash[key].empty?)
      hash[key]
    end
  end
end
