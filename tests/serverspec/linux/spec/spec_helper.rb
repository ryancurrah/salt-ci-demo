require 'serverspec'
require 'yarjuf'
require 'yaml'

set :backend, :exec

begin
  properties = YAML.load_file('/etc/salt/grains')
rescue Errno::ENOENT 
  properties = Hash.new
end

set_property properties
