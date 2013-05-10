module Splicer
  module DnsMadeEasy

    class Provider
      attr_reader :client

      def initialize(config)
        @config = config
        @client = config.client
      end

      def publish(zone, method)
        case method
        when :rewrite
          rewrite(zone)
        when :merge
          merge(zone)
        else
          false
        end
      end

      # Destroys a zone
      def destroy(zone)
        domain = search(zone.name)
        id = domain['id']
        client.delete("dns/managed/#{id}")
        true
      end

      private

      def rewrite(zone)
        domain = search(zone.name)
        unless domain
          domain = create_domain(zone.name)
        end

        # Nuke all of the records in a zone
        records = JSON.parse(client.get(domain_records_url(domain)))['data']
        unless records.empty?
          delete_records(domain, records.collect { |r| r['id'] })
        end

        # Time to populate the zone
        zone.records.each do |record|
          create_record(domain, record)
        end
      end

      def merge(zone)
        domain = search(zone.name)
        unless domain
          domain = create_domain(zone.name)
        end

        zone.records.each do |record|
          records = search_for_record(domain, record)
          if records
            delete_records(domain, records.collect { |r| r['id'] })
          end
          create_record(domain, record)
        end
      end

      def create_record(domain, record)
        payload = { type: record.type, gtdLocation: 'DEFAULT', ttl: record.ttl }
        payload[:name] = record.name ? record.name : ''
        case record
          when Splicer::Records::ARecord
            payload.merge!({ value: record.ip })
          when Splicer::Records::AAAARecord
            payload.merge!({ value: record.ip })
          when Splicer::Records::CNAMERecord
            payload.merge!({ value: record.cname })
          when Splicer::Records::MXRecord
            payload.merge!({ value: record.exchanger, mxLevel: record.priority })
          when Splicer::Records::NSRecord
            payload.merge!({ value: record.server })
          when Splicer::Records::PTRRecord
            payload.merge!({ value: record.host })
          when Splicer::Records::SRVRecord
            payload.merge!({
              value: record.target,
              weight: record.weight,
              priority: record.priority,
              port: record.port
            })
          when Splicer::Records::TXTRecord
            payload.merge!({
              value: record.text
            })
          else
            return nil
          end
          client.post(domain_records_url(domain), payload)
      end

      def search_for_record(domain, record)
        payload = { type: record.type }
        payload[:recordName] = record.name ? record.name : ''
        resp = client.get(domain_records_url(domain), payload)
        JSON.parse(resp)['data']
      end

      def domain_records_url(domain)
        "dns/managed/#{domain['id']}/records"
      end

      def create_domain(name)
        JSON.parse(client.post('dns/managed', name: name))
      end

      def delete_records(domain, ids)
        return true if ids.empty?
        client.delete(domain_records_url(domain), ids: ids)
      end

      # Search for a domain
      # @param [String] name the name of the domain you wish to look for
      # @return [Hash] nil if it can't be found
      def search(name)
        JSON.parse(client.get("dns/managed/id/#{name}"))
      rescue Splicer::Errors::RequestError => error
        nil
      end
    end

  end
end
