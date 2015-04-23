require 'spec_helper'
describe 'pm2' do

  context 'with defaults for all parameters' do
    it { should contain_class('pm2') }
  end
end
