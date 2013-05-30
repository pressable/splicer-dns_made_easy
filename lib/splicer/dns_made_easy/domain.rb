module Splicer
  module DnsMadeEasy

    class Domain
      attr_reader :id, :data

      def initialize(params={})
        @id = params['id']
        @data = params
      end

      def persisted?
        !!@id
      end
      alias_method :id?, :persisted?

    end

  end
end
