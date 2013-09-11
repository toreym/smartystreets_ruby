# -*- encoding: utf-8 -*-

require 'centzy_common'
require 'httparty'
require 'multi_json'

module SmartyStreets
  class StreetAddressApi
    class << self
      include CentzyCommon::Preconditions
    end

    private_class_method :new

    def self.call(*street_address_requests)
      check_array_element_types(street_address_requests, StreetAddressRequest)
      street_address_responses(HTTParty.post(request_url, request(*street_address_requests)))
    end

    private

    def self.request(*street_address_requests)
      {
        :query => query,
        :body => body(*street_address_requests),
        :headers => headers
      }
    end


    def self.request_url
      @@request_url ||= SmartyStreets.api_url + "/street-address"
      @@request_url
    end

    def self.query
      @@query ||= {
        "auth-id" => SmartyStreets.auth_id,
        "auth-token" => SmartyStreets.auth_token
      }
      @@query
    end

    def self.body(*street_address_requests)
      MultiJson.dump(street_address_requests)
    end

    def self.headers
      @@headers ||= {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "x-standardize-only" => "false",
        "x-accept-keypair" => "false"
      }
      @@headers
    end

    def self.street_address_responses(response)
      raise ApiError.from_code(response.code) unless response.code == 200
      raise ApiError.from_code(ApiError::NO_VALID_CANDIDATES) if response.body == nil || response.body.empty?
      MultiJson.load(response.body)
    end

    #location = Location.new
    #location.street = l['delivery_line_1']
    #location.city = l['components']['city_name']
    #location.state = l['components']['state_abbreviation']
    #location.zip_code = l['components']['zipcode'] + '-' + l['components']['plus4_code']
    #location.delivery_point_barcode = l['delivery_point_barcode']
    #location.components = l['components']
    #location.meta_data = l['metadata']
    #location
  end
end
