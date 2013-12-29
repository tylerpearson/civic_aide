require 'httparty'
require 'forwardable'

module CivicAide
  class Client
    extend Forwardable
    include HTTParty

    API_ENDPOINT = 'https://www.googleapis.com/civicinfo/'.freeze
    API_VERSION = 'us_v1'.freeze

    base_uri "#{API_ENDPOINT}#{API_VERSION}"
    headers  "Content-Type" => "application/json"
    headers  "User-Agent" => "CivicAide Ruby gem v#{CivicAide::VERSION}".freeze

    attr_reader :api_key

    def initialize(api_key=nil)
      @api_key = api_key
      @api_key ||= CivicAide.api_key
    end

    def get(url, query={})
      response = self.class.get(url, :query => query.merge(self.default_query))
      format_response(response.body)
    end

    def post(url, query={}, body={})
      response = self.class.post(url,
          :query => query.merge(self.default_query),
          :body => body.to_json
        )
      check_response_status(response['status'])
      format_response(response.body)
    end

    def elections(election_id=nil)
      CivicAide::Elections.new(self, election_id)
    end

    def representatives
      CivicAide::Representatives.new(self)
    end

    protected

      def default_query
        {:key => @api_key, :prettyPrint => false}
      end

      def format_response(body)
        body = JSON.parse(body)
        body.change_zip! # to prevent Array#zip clashing when rubifying the keys
        body.rubyify_keys!
        Hashie::Mash.new(body)
      end

      def check_response_status(code)
        unless code.downcase == "success"
          error_type = classify_error(code)
          raise error_type
        end
      end

      def classify_error(code)
        code.slice(0,1).capitalize + code.slice(1..-1)
      end

  end
end