# -*- encoding: utf-8 -*-

require 'centzy_common'

module SmartyStreets

  # Base class for json requests and responses
  #
  # @author Peter Edge <peter@centzy.com>
  class BaseJsonObject
    include CentzyCommon::Preconditions

    def initialize(hash)
      check_hash_key_types(hash, Symbol)
      check_hash_value_types(hash, String, Hash)
    end

    private

    def get_optional_string(hash, key)
      hash.has_key?(key) && !hash[key].empty? ? check_type(hash[key], String) : nil
    end

    def get_required_string(hash, key)
      check_argument(hash.has_key?(key))
      check_argument(!hash[key].empty?)
      check_type(hash[key], String)
    end

    def get_optional_hash(hash, key)
      hash.has_key?(key) && !hash[key].empty? ? check_type(hash[key], Hash) : nil
    end

    def get_required_hash(hash, key)
      check_argument(hash.has_key?(key))
      check_argument(!hash[key].empty?)
      check_type(hash[key], Hash)
    end
  end
end
