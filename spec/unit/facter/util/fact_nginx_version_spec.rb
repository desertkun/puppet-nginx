require 'spec_helper'

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe 'nginx_version' do
    context 'with current version output format' do
      before :each do
        Facter::Util::Resolution.stubs(:which).with('nginx').returns(true)
        Facter::Util::Resolution.stubs(:exec).with('nginx -v 2>&1').returns('nginx version: nginx/1.8.1')
      end
      it do
        expect(Facter.fact(:nginx_version).value).to eq('1.8.1')
      end
    end
    context 'with old version output format' do
      before :each do
        Facter::Util::Resolution.stubs(:which).with('nginx').returns(true)
        Facter::Util::Resolution.stubs(:exec).with('nginx -v 2>&1').returns('nginx: nginx version: nginx/0.7.0')
      end
      it do
        expect(Facter.fact(:nginx_version).value).to eq('0.7.0')
      end
    end
  end
end
