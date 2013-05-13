module Splicer
  module DnsMadeEasy

    class Record
      attr_reader :id, :type, :value, :ttl, :data
      def initialize(params={})
        @id = params['id']
        @type = params['type']
        @value = params['value']
        @ttl = params['ttl']
        @data = params
      end

      def id?
        !!@id
      end
    end

  end
end
