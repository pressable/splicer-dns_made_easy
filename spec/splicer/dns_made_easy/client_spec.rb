require 'spec_helper'

describe Splicer::DnsMadeEasy::Client do
  let(:client) { Splicer::DnsMadeEasy::Client.new('key','secret') }
  describe '#initialize' do
    it "should initialize" do
      expect(client).to be_a(Splicer::DnsMadeEasy::Client)
    end
  end

  describe '#post' do
    subject { client.post('resource', { data: 'something' }) }

    context 'when Dynect returns with success' do
      before { client.stub(:execute).and_return({}) }
      it { should eq({})}
    end

    context 'when Dynect returns with an error' do
      before { client.stub(:execute).and_raise(Splicer::Errors::RequestError) }
      it 'should raise a Splicer::Errors::RequestError' do
        expect { subject }.to raise_error(Splicer::Errors::RequestError)
      end
    end
  end

  describe '#get' do
    subject { client.get('resource') }

    context 'when Dynect returns with success' do
      before { client.stub(:execute).and_return({}) }
      it { should eq({})}
    end

    context 'when Dynect returns with an error' do
      before { client.stub(:execute).and_raise(Splicer::Errors::RequestError) }
      it 'should raise a Splicer::Errors::RequestError' do
        expect { subject }.to raise_error(Splicer::Errors::RequestError)
      end
    end
  end

  describe '#put' do
    subject { client.put('resource', { data: 'something' }) }

    context 'when Dynect returns with success' do
      before { client.stub(:execute).and_return({}) }
      it { should eq({})}
    end

    context 'when Dynect returns with an error' do
      before { client.stub(:execute).and_raise(Splicer::Errors::RequestError) }
      it 'should raise a Splicer::Errors::RequestError' do
        expect { subject }.to raise_error(Splicer::Errors::RequestError)
      end
    end
  end

  describe '#delete' do
    subject { client.delete('resource') }

    context 'when Dynect returns with success' do
      before { client.stub(:execute).and_return({}) }
      it { should eq({})}
    end

    context 'when Dynect returns with an error' do
      before { client.stub(:execute).and_raise(Splicer::Errors::RequestError) }
      it 'should raise a Splicer::Errors::RequestError' do
        expect { subject }.to raise_error(Splicer::Errors::RequestError)
      end
    end
  end

end
