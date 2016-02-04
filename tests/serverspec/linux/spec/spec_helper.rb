require 'serverspec'
require 'yarjuf'
require 'yaml'

set :backend, :exec

properties = YAML.load_file('/etc/salt/grains')

set_property properties
