module Splicer
  module DnsMadeEasy

    class Record
      attr_accessor :name, :value, :id, :type, :dynamicDns,
                    :failed, :gtdLocation, :hardLink, :ttl,
                    :failover, :monitor, :sourceId, :source,
                    :data, :mxLevel

      def initialize(params={})
        @id = params['id']
        @type = params['type']
        @value = params['value']
        @ttl = params['ttl']
        @data = params
      end

      def persisted?
        !!@id
      end
      alias_method :id?, :persisted?
    end

  end
end
