module Splicer
  module DnsMadeEasy

    class Record
      attr_accessor :data, :description, :dynamicDns, :failed, :failover, :gtdLocation, :hardLink, :id, :keywords,
                    :monitor, :mxLevel, :name, :redirectType, :source, :sourceId, :title, :ttl, :type, :value

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
