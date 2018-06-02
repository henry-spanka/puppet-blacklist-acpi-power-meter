require 'spec_helper'
describe 'blacklist_acpi_power_meter' do
  context 'with default values for all parameters' do
    it { should contain_class('blacklist_acpi_power_meter') }
  end
end
