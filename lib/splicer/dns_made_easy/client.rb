module Splicer
  module DnsMadeEasy

    # The client that talks to DnsMadeEasy
    #
    # ## Example Usage
    #   client = Splicer::DnsMadeEasy::Client.new('key','secret')
    #   client.get('dns/managed/123456')
    #
    #   client.post('dns/managed', {name: 'mydumbdomain.com'})
    #
    # @author Matthew A. Johnston
    class Client

      DEFAULT_END_POINTS = {
        :sandbox => "https://api.sandbox.dnsmadeeasy.com/V2.0",
        :live    => "https://api.dnsmadeeasy.com/V2.0"
      }

      # @param [String] key
      # @param [String] secret
      def initialize(key, secret, api_mode = :live)
        @key = key
        @secret = secret
        @api_mode = api_mode
      end

      # @param [String] resource the resource path
      #
      # @raise [Splicer::Errors::Error] when the request fails
      # @return [String]
      def get(resource, params={})
        execute({
          method: :get,
          url: resource_url(resource),
          headers: headers('params' => params)
        })
      end


      # @param [String] resource the resource path
      # @param [Hash] payload the data you wish to send
      #
      # @raise [Splicer::Errors::Error] when the request fails
      # @return [String]
      def post(resource, payload)
        execute({
          method: :post,
          url: resource_url(resource),
          payload: process_payload(payload),
          headers: headers
        })
      end

      # @param [String] resource the resource path
      # @param [Hash] payload the data you wish to send
      #
      # @raise [Splicer::Errors::Error] when the request fails
      # @return [String]
      def put(resource, payload)
        execute({
          method: :put,
          url: resource_url(resource),
          payload: process_payload(payload),
          headers: headers
        })
      end

      # @param [String] resource the resource path
      # @param [Hash] payload the data you wish to send
      #
      # @raise [Splicer::Errors::Error] when the request fails
      # @return [String]
      def delete(resource, payload={})
        execute({
          method: :delete,
          url: resource_url(resource),
          payload: process_payload(payload),
          headers: headers
        })
      end

      private

      # Wrapper around RestClient::Request.execute method
      #
      # @param [Hash] args
      # @raise [Splicer::Errors::Error] when the request fails
      # @return [Hash]
      def execute(args={})
        response = RestClient::Request.execute(args)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] method=#{args[:method]} url=#{args[:url]} headers=#{args[:headers]} payload=#{args[:payload]} response=#{response}"
        response
      rescue RestClient::Exception => error
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] method=#{args[:method]} url=#{args[:url]} request_headers=#{args[:headers]} payload=#{args[:payload]} response_headers=#{error.response.raw_headers}"
        raise Splicer::Errors::RequestError.new(error)
      end

      # Processes the payload to see if it needs to be turned in to JSON
      #
      # @return [String]
      def process_payload(payload)
        payload.is_a?(String) ? payload : payload.to_json
      end

      # @param [Hash] params
      # @return [Hash]
      def headers(params={})
        @headers ||= {}
        @headers['x-dnsme-apiKey']      = @key
        @headers['x-dnsme-requestDate'] = Splicer::DnsMadeEasy::Time.now.to_date_header
        @headers['x-dnsme-hmac']        = signature
        @headers['Accept']              = 'application/json'
        @headers['Content-Type']        = 'application/json'
        @headers.merge!(params)
        @headers
      end

      # @param [Hash] params
      # @return [String]
      def signature
        OpenSSL::HMAC.hexdigest('sha1', @secret, @headers['x-dnsme-requestDate'])
      end

      def resource_url(resource)
        [base_url, resource.gsub(/^\//,'')].join('/')
      end

      def base_url
        DEFAULT_END_POINTS[@api_mode]
      end

    end

  end
end
