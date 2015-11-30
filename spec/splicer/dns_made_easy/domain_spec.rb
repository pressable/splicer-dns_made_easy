require 'spec_helper'

describe Splicer::DnsMadeEasy::Domain do

  describe '#initialize' do
    def params
      { 'id' => 1 }
    end
    subject { Splicer::DnsMadeEasy::Domain.new(params) }

    it 'should find :id to be equal to 1' do
      expect(subject.id).to eq(1)
    end

    it 'should find :data to be equal to passed params' do
      expect(subject.data).to eq(params)
    end
  end

  describe '#persisted?' do
    subject { domain.persisted? }
    context 'when the domain is persisted' do
      let(:domain) { Splicer::DnsMadeEasy::Domain.new({'id' => 1}) }
      it { should be_truthy }
    end

    context 'when the domain is not persisted' do
      let(:domain) { Splicer::DnsMadeEasy::Domain.new }
      it { should be_falsy }
    end
  end
end
