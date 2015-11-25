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

    it "should find :id to be equal to passed params['id']" do
      expect(subject.id).to eq(params['id'])
    end

    it "should find :type to be equal to passed params['type']" do
      expect(subject.type).to eq(params['type'])
    end

    it "should find :value to be equal to passed params['value']" do
      expect(subject.value).to eq(params['value'])
    end

    it "should find :ttl to be equal to passed params['ttl']" do
      expect(subject.ttl).to eq(params['ttl'])
    end

    it "should find :data to be equal to passed params" do
      expect(subject.data).to eq(params)
    end
  end

  describe '#persisted?' do
    subject { record.persisted? }
    context 'when the record is persisted' do
      let(:record) { Splicer::DnsMadeEasy::Record.new({'id' => 1}) }
      it { should be_truthy }
    end

    context 'when the record is not persisted' do
      let(:record) { Splicer::DnsMadeEasy::Record.new }
      it { should be_falsy }
    end
  end
end
