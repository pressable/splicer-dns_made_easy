module Splicer
  module DnsMadeEasy

    # @author Matthew A. Johnston <warmwaffles@gmail.com>
    class Provider < Splicer::Provider
      attr_reader :client

      def initialize(config)
        @config = config
        @client = Client.new(config.key, config.secret, config.api_mode)
      end

      def create_zone(zone)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] #create_zone zone=#{zone.inspect}"
        domain = find_domain(zone.name)
        return false if domain.persisted?

        create_domain(zone)

        zone.records.each do |record|
          create_record(domain.id, record)
        end
        true
      end

      def delete_zone(zone)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] #delete_zone zone=#{zone.inspect}"
        domain = find_domain(zone.name)
        return false unless domain.persisted?
        client.delete(domain_resource_url(domain.id))
      end

      def delete_record_in_zone(record, zone)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] #delete_record_in_zone record=#{record.inspect} zone=#{zone.inspect}"
        domain = find_domain(zone.name)
        return false unless domain.persisted?

        records = find_records(record.name, record.type, domain.id)
        return false if records.empty?

        delete_record(domain.id, records.first.id)
      end

      def update_record_in_zone(record, zone)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] #update_record_in_zone record=#{record.inspect} zone=#{zone.inspect}"
        domain = find_domain(zone.name)
        return false unless domain.persisted?

        records = find_records(record.name, record.type, domain.id)
        return false if records.empty?
        update_record(domain.id, records.first.id, record)
      end

      def create_record_in_zone(record, zone)
        Splicer.logger.debug "[SPLICER][DNSMADEEASY] #create_record_in_zone record=#{record.inspect} zone=#{zone.inspect}"
        domain = find_domain(zone.name)
        unless domain.persisted?
          create_domain(zone)
          domain = find_domain(zone.name)
        end

        records = find_records(record.name, record.type, domain.id)
        return false unless records.empty?
        create_record(domain.id, record)
      end

      private

      # @param [Integer] domain_id
      # @return [Array<Splicer::DnsMadeEasy::Record>]
      def fetch_records(domain_id)
        response = JSON.parse(client.get(record_url(domain_id)))
        list = []
        response['data'].each do |r|
          list << Record.new(r)
        end
        list
      rescue Splicer::Errors::RequestError => error
        []
      end

      # @param [Integer] domain_id
      # @param [String] type
      # @return [Array<Splicer::DnsMadeEasy::Record>]
      def find_records(name, type, domain_id)
        payload = {
          type: type,
          recordName: name ? name : ''
        }
        response = JSON.parse(client.get(record_url(domain_id), payload))
        if response['data'].is_a?(Array)
          list = []
          response['data'].each do |params|
            list << Record.new(params)
          end
          list
        else
          [Record.new(response['data'])]
        end
      rescue Splicer::Errors::Error => error
        []
      end

      def create_domain(zone)
        client.post('dns/managed', name: zone.name)
      end

      # @param [Integer] domain_id
      # @param [Splicer::Records::Record] splicer_record
      # @return [String]
      def create_record(domain_id, splicer_record)
        url = record_url(domain_id)
        payload = record_payload(splicer_record)
        client.post(url, payload)
      end

      # @param [Integer] record_id
      # @param [Integer] domain_id
      # @param [Splicer::Records::Record] splicer_record
      # @return [String]
      def update_record(domain_id, record_id, splicer_record)
        url = record_url(domain_id, record_id)
        payload = record_payload(splicer_record).merge({id: record_id})
        client.put(url, payload)
      end

      # @param [Integer] record_id
      # @param [Integer] domain_id
      # @return [String]
      def delete_record(domain_id, record_id)
        url = record_url(domain_id, record_id)
        payload = { id: record_id }
        client.delete(url, payload)
      end

      # @param [Integer] domain_id
      # @return [String]
      def record_url(domain_id, record_id=nil)
        if record_id
          "dns/managed/#{domain_id}/records/#{record_id}"
        else
          "dns/managed/#{domain_id}/records"
        end
      end

      # @param [Integer] domain_id
      # @return [String]
      def domain_resource_url(domain_id)
        "dns/managed/#{domain_id}"
      end

      def find_domain(name)
        response = JSON.parse(client.get("dns/managed/id/#{name}"))
        Domain.new(response)
      rescue Splicer::Errors::RequestError => error
        Domain.new
      end

      # Returns a hash for the record data
      # @param [Splicer::Records::Record] record
      # @return [Hash]
      def record_payload(record)
        payload = {
          type: record.type,
          gtdLocation: 'DEFAULT',
          name: record.name ? record.name : '',
          ttl: record.ttl
        }
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
          payload = {}
        end
        payload
      end
    end

  end
end
