require 'spec_helper'

describe file('/etc/timezone') do
  it { should be_file }

  it { should be_mode 644 }
 
  it { should be_owned_by 'root' }

  it { should be_grouped_into 'root' }
end

describe command('date') do
  its(:stdout) { should match /UTC/ }
end
