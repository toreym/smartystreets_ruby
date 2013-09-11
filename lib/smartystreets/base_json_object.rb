# -*- encoding: utf-8 -*-

require 'centzy_common'

module SmartyStreets

  # Base class for json requests and responses.
  #
  # @author Peter Edge <peter@centzy.com>
  class BaseJsonObject
    include CentzyCommon::Preconditions

    def initialize(hash)
      check_hash_key_types(hash, Symbol)
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

    def get_optional_fixnum(hash, key)
      hash.has_key?(key) ? check_type(hash[key], Fixnum) : nil
    end

    def get_required_fixnum(hash, key)
      check_argument(hash.has_key?(key))
      check_type(hash[key], Fixnum)
    end

    def get_optional_float(hash, key)
      hash.has_key?(key) ? check_type(hash[key], Float) : nil
    end

    def get_required_float(hash, key)
      check_argument(hash.has_key?(key))
      check_type(hash[key], Float)
    end

    def get_optional_hash(hash, key)
      hash.has_key?(key) && !hash[key].empty? ? check_type(hash[key], Hash) : nil
    end

    def get_required_hash(hash, key)
      check_argument(hash.has_key?(key))
      check_argument(!hash[key].empty?)
      check_type(hash[key], Hash)
    end

    def get_optional_array(hash, key)
      hash.has_key?(key) && !hash[key].empty? ? check_type(hash[key], Array) : nil
    end

    def get_required_array(hash, key)
      check_argument(hash.has_key?(key))
      check_argument(!hash[key].empty?)
      check_type(hash[key], Array)
    end
  end
end
