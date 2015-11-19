require 'spec_helper'

describe Splicer::DnsMadeEasy::Config do
  let(:config) { Splicer::DnsMadeEasy::Config.new('key', 'secret') }

  describe '#initialize' do
    subject { config }

    it "should find key to be equal to 'key'" do
      expect(config.key).to eq('key')
    end

    it "should find secret to be equal to 'secret'" do
      expect(config.secret).to eq('secret')
    end
  end

  describe '#provider' do
    subject { config.provider }
    it { should be_a(Splicer::DnsMadeEasy::Provider) }
  end
end
