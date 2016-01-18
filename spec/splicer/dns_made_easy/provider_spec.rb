require 'spec_helper'

describe Splicer::DnsMadeEasy::Provider do
  let(:config) { Splicer::DnsMadeEasy::Config.new('key','secret') }
  let(:provider) { Splicer::DnsMadeEasy::Provider.new(config) }
  let(:domain) { Splicer::DnsMadeEasy::Domain.new({'id' => 1}) }

  describe '#create_zone' do
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.create_zone(zone) }

    context 'when the domain exists' do
      before do
        provider.stub(:find_domain).and_return(domain)
        provider.stub(:create_domain).and_raise(Splicer::Errors::RequestError)
      end
      it { should be_falsy }
    end

    context 'when the domain exists' do
      before do
        provider.stub(:find_domain).and_return(Splicer::DnsMadeEasy::Domain.new)
        provider.stub(:create_domain).and_return(true)
        provider.stub(:create_record).and_return(true)
      end
      it { should be_truthy }
    end
  end


  describe '#delete_zone' do
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.delete_zone(zone) }
  end


  describe '#delete_record_in_zone' do
    let(:record) { Splicer::Records::ARecord.new(nil, '127.0.0.1') }
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.delete_record_in_zone(record, zone) }
  end


  describe '#update_record_in_zone' do
    let(:record) { Splicer::Records::ARecord.new(nil, '127.0.0.1') }
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.update_record_in_zone(record, zone) }
  end


  describe '#create_record_in_zone' do
    let(:record) { Splicer::Records::ARecord.new(nil, '127.0.0.1') }
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.create_record_in_zone(record, zone) }
  end


  describe '#get_records_for' do
    let(:params) { { 'id' => 1, 'type' => 'A', 'value' => '127.0.0.1', 'ttl' => 3600 } }
    let(:records) { [Splicer::DnsMadeEasy::Record.new(params)] }
    let(:zone) { Splicer::Zone.new('rspectesting.com') }
    subject { provider.get_records_for(zone) }

    context 'when the domain exists' do
      before do
        provider.stub(:find_domain).and_return(domain)
        provider.stub(:fetch_records).and_return(records)
      end
      it { is_expected.to eq(records) }
    end

    context 'when the domain does not exist' do
      before do
        provider.stub(:find_domain).and_return(Splicer::DnsMadeEasy::Domain.new)
      end

      it { is_expected.to eq([]) }
    end
  end
end
