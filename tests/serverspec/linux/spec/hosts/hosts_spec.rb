require 'socket'
require 'spec_helper'


describe file('/etc/hosts') do
  it { should be_file }

  it { should be_mode 644 }

  it { should be_owned_by 'root' }

  it { should be_grouped_into 'root' }
end

describe 'Hostname is resolvable by /etc/hosts' do
  describe host(Socket.gethostname) do
      it { should be_resolvable.by('hosts') }
      it { should be_reachable }
  end
end

describe 'FQDN is resolvable by /etc/hosts' do
  describe host(Socket.gethostbyname(Socket.gethostname).first) do
      it { should be_resolvable.by('hosts') }
      it { should be_reachable }
  end
end

describe 'localhost is resolvable by /etc/hosts' do
  describe host('localhost') do
      it { should be_resolvable.by('hosts') }
      it { should be_reachable }
  end
end
