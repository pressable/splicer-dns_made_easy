module Splicer
  module DnsMadeEasy

    class Config
      attr_reader :key, :secret

      def initialize(key, secret)
        @key = key
        @secret = secret
      end

      def provider
        Provider.new(self)
      end

      def client
        Client.new(key, secret)
      end
    end

  end
end
