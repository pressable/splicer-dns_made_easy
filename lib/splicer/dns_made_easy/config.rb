module Splicer
  module DnsMadeEasy

    class Config
      attr_reader :key, :secret, :api_mode, :use_ssl

      def initialize(key, secret, options = {})
        @key = key
        @secret = secret
        @api_mode = options[:api_mode] || :live
        @use_ssl = options[:use_ssl]
      end

      def provider
        Provider.new(self)
      end
    end

  end
end
