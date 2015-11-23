module Splicer
  module DnsMadeEasy

    class Record
      attr_reader :name, :value, :id, :type, :dynamicDns,
                  :failed, :gtdLocation, :hardLink, :ttl,
                  :failover, :monitor, :sourceId, :source, :data

      def initialize(params={})
        @id = params['id']
        @type = params['type']
        @value = params['value']
        @ttl = params['ttl']
        @data = params
      end

      def add_attribute(attribute, value)
        attribute = "@#{attribute}"
        self.instance_variable_set(attribute, value)
      end

      def persisted?
        !!@id
      end
      alias_method :id?, :persisted?
    end

  end
end
