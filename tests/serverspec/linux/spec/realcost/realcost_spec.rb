require 'spec_helper'

if property.has_key? 'app' and property['app'].include? 'realcost' then
  describe 'realcost application' do
    describe package('apache2') do
      it { should be_installed }
    end

    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end

    describe port(80) do
      it { should be_listening }
    end

    describe file('/etc/apache2/sites-enabled/000-default.conf') do
      it { should_not exist }
    end

    describe file('/etc/apache2/sites-enabled/001-realcost.conf') do
      it { should be_file }
      it { should be_mode 640 }
      it { should be_owned_by 'www-data' }
      its(:md5sum) { should eq 'd5bffd98db347b398b94bec3cce47ba9' }
    end

    describe file('/var/www/realcost') do
      it { should be_directory }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
    end

    describe file('/var/venvs/realcost') do
      it { should be_directory }
      it { should be_mode 750 }
      it { should be_owned_by 'www-data' }
    end

    describe command('curl localhost:80') do
      its(:stdout) { should match(/<title>The Real Cost of Car Loans<\/title>/) }
      its(:exit_status) { should eq 0 }
    end
  end
end

