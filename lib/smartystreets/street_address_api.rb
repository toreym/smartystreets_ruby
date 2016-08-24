# -*- encoding: utf-8 -*-

module SmartyStreets
  
  # Exposes calls to the SmartyStreets Street Address API.
  #
  # @author Peter Edge (peter.edge@gmail.com)
  class StreetAddressApi
    class << self
      include Util
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


    @@request_url = LazyLoader.create_lazy_loader do
      SmartyStreets.api_url + '/street-address'
    end

    def self.request_url
      @@request_url.get
    end

    @@query = LazyLoader.create_lazy_loader do
      {
        'auth-id' => SmartyStreets.auth_id,
        'auth-token' => SmartyStreets.auth_token
      }
    end

    def self.query
      @@query.get
    end

    def self.body(*street_address_requests)
      MultiJson.dump(street_address_requests)
    end

    @@headers = LazyLoader.create_lazy_loader do
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'x-standardize-only' => 'true',
        'x-accept-keypair' => 'false'
      }
    end

    def self.headers
      @@headers.get
    end

    def self.street_address_responses(response)
      raise ApiError.from_code(response.code) unless response.code == 200
      MultiJson.load(response.body, :symbolize_keys => true).map do |response_element|
        StreetAddressResponse.new(response_element)
      end
    end
  end
end
