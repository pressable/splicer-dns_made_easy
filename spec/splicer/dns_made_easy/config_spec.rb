require 'spec_helper'

describe Splicer::DnsMadeEasy::Config do
  let(:config) { Splicer::DnsMadeEasy::Config.new('key', 'secret') }

  describe '#initialize' do
    subject { config }
    its(:key) { should eq('key') }
    its(:secret) { should eq('secret') }
  end

  describe '#provider' do
    subject { config.provider }
    it { should be_a(Splicer::DnsMadeEasy::Provider) }
  end
end
