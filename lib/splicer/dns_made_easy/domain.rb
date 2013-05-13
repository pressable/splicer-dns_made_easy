module Splicer
  module DnsMadeEasy

    class Domain
      attr_reader :id, :data

      def initialize(params={})
        @id = params['id']
        @data = params
      end

      def id?
        !!@id
      end

      def persisted?
        id?
      end
    end

  end
end
