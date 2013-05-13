require 'spec_helper'

describe Splicer::DnsMadeEasy::Provider do
  let(:config) { Splicer::DnsMadeEasy::Config.new('key','secret') }
  let(:provider) { Splicer::DnsMadeEasy::Provider.new(config) }

  describe '#create_zone' do
    subject { provider.create_zone(zone) }
  end

  describe '#update_zone' do
    subject { provider.update_zone(zone) }
  end

  describe '#rewrite_zone' do
    subject { provider.rewrite_zone(zone) }
  end

  describe '#delete_zone' do
    subject { provider.delete_zone(zone) }
  end

  describe '#delete_record_in_zone' do
    subject { provider.delete_record_in_zone(record, zone) }
  end

  describe '#update_record_in_zone' do
    subject { provider.update_record_in_zone(record, zone) }
  end

  describe '#create_record_in_zone' do
    subject { provider.create_record_in_zone(record, zone) }
  end
end
