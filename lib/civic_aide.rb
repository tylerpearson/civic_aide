require 'forwardable'
require 'hashie'
require 'civic_aide/version'
require 'civic_aide/client'
require 'civic_aide/hash'
require 'civic_aide/string'
require 'civic_aide/elections'
require 'civic_aide/representatives'
require 'civic_aide/errors'

module CivicAide
  class << self
    extend Forwardable
    attr_accessor :official_only

    def api_key
      raise APIKeyNotSet if @api_key.nil?
      @api_key
    end

    def api_key=(api_key)
      @api_key = api_key
    end

    def official_only
      @official_only ||= false
    end

    delegate [
      :elections,
      :representatives
    ] => :client

    def client
      @client = CivicAide::Client.new(@api_key, @official_only)
    end

  end
end