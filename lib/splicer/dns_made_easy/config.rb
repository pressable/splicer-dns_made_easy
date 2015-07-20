module Splicer
  module DnsMadeEasy

    class Config
      attr_reader :key, :secret, :environment

      def initialize(key, secret, environment = :live)
        @key = key
        @secret = secret
        @environment = environment
      end

      def provider
        Provider.new(self)
      end
    end

  end
end
