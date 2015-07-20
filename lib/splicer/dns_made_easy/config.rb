module Splicer
  module DnsMadeEasy

    class Config
      attr_reader :key, :secret, :api_mode

      def initialize(key, secret, api_mode = :live)
        @key = key
        @secret = secret
        @api_mode = api_mode
      end

      def provider
        Provider.new(self)
      end
    end

  end
end
