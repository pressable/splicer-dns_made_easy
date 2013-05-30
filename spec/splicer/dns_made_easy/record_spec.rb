require 'spec_helper'

describe Splicer::DnsMadeEasy::Record do
  describe '#initialize' do
    def params
      {
        'id' => 1,
        'type' => 'A',
        'value' => '127.0.0.1',
        'ttl' => 3600
      }
    end
    subject { Splicer::DnsMadeEasy::Record.new(params) }
    its(:id) { should eq(params['id']) }
    its(:type) { should eq(params['type']) }
    its(:value) { should eq(params['value']) }
    its(:ttl) { should eq(params['ttl']) }
    its(:data) { should eq(params) }
  end

  describe '#persisted?' do
    subject { record.persisted? }
    context 'when the record is persisted' do
      let(:record) { Splicer::DnsMadeEasy::Record.new({'id' => 1}) }
      it { should be_true }
    end

    context 'when the record is not persisted' do
      let(:record) { Splicer::DnsMadeEasy::Record.new }
      it { should be_false }
    end
  end
end
