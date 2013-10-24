# -*- encoding: utf-8 -*-

require 'centzy_common'
require 'httparty'
require 'multi_json'

module SmartyStreets
  
  # Exposes calls to the SmartyStreets Zipcode API.
  #
  # @author Peter Edge <peter@centzy.com>
  class ZipcodeApi
    class << self
      include CentzyCommon::Preconditions
    end

    private_class_method :new

    def self.call(*zipcode_requests)
      check_array_element_types(zipcode_requests, ZipcodeRequest)
      zipcode_responses(HTTParty.post(request_url, request(*zipcode_requests)))
    end

    private

    def self.request(*zipcode_requests)
      {
        :query => query,
        :body => body(*zipcode_requests),
        :headers => headers
      }
    end

    @@request_url = CentzyCommon::Thread::LazyLoad.new do
      SmartyStreets.api_url + "/zipcode"
    end

    def self.request_url
      @@request_url.get
    end

    @@query = CentzyCommon::Thread::LazyLoad.new do {
        "auth-id" => SmartyStreets.auth_id,
        "auth-token" => SmartyStreets.auth_token
      }
    end

    def self.query
      @@query.get
    end

    def self.body(*zipcode_requests)
      MultiJson.dump(zipcode_requests)
    end

    @@headers = CentzyCommon::Thread::LazyLoad.new do {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    end

    def self.headers
      @@headers.get
    end

    def self.zipcode_responses(response)
      raise ApiError.from_code(response.code) unless response.code == 200
      MultiJson.load(response.body, :symbolize_keys => true).map do |response_element|
        ZipcodeResponse.new(response_element)
      end
    end
  end
end
