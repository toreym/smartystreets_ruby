# -*- encoding: utf-8 -*-

module SmartyStreets

  # Utility functions.
  #
  # @author Peter Edge (peter@locality.com)
  module Util

    @@lock = Mutex.new
    @@type_checking = true

    def self.set_type_checking(type_checking)
      @@lock.synchronize do
        @@type_checking = type_checking
      end
      nil
    end

    def self.type_checking?
      @@type_checking
    end

    def check_argument(expression, message_lambda = nil)
      raise ArgumentError.new(message_lambda ? message_lambda.call : nil) unless expression
      nil
    end

    def check_not_nil(object, message_lambda = nil)
      raise ArgumentError.new(message_lambda ? message_lambda.call : nil) unless object != nil
      object
    end

    def check_type(object, *expected_classes)
      check_not_nil(object)
      return object unless @@type_checking
      if expected_classes.size == 1
        check_argument(object.is_a?(expected_classes.first))
        return object
      end
      expected_classes.each do |expected_class|
        if (object.is_a?(expected_class))
          return object
        end
      end
      check_argument(false)
    end

    def check_array_element_types(array, *expected_classes)
      check_type(array, Array)
      return array unless @@type_checking
      array.each do |element|
        check_type(element, *expected_classes)
      end
      array
    end

    def check_hash_key_types(hash, *expected_classes)
      check_type(hash, Hash)
      return hash unless @@type_checking
      hash.each do |key, value|
        check_type(key, *expected_classes)
      end
      hash
    end
  end
end
