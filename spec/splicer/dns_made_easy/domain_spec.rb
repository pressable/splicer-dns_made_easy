require 'spec_helper'

describe Splicer::DnsMadeEasy::Domain do

  describe '#initialize' do
    def params
      { 'id' => 1 }
    end
    subject { Splicer::DnsMadeEasy::Domain.new(params) }
    its(:id) { should eq(1) }
    its(:data) { should eq(params) }
  end

  describe '#persisted?' do
    subject { domain.persisted? }
    context 'when the domain is persisted' do
      let(:domain) { Splicer::DnsMadeEasy::Domain.new({'id' => 1}) }
      it { should be_true }
    end

    context 'when the domain is not persisted' do
      let(:domain) { Splicer::DnsMadeEasy::Domain.new }
      it { should be_false }
    end
  end
end
