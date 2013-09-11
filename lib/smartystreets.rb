# -*- encoding: utf-8 -*-

lib = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

#require 'centzy_api'

require 'smartystreets/version'

module SmartyStreets
  class Error < StandardError
  end
end
