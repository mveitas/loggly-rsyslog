require 'chefspec'
require 'chefspec/berkshelf'

CHEF_RUN_OPTIONS = {
  :platform => 'ubuntu',
  :version => '12.04'
}

at_exit { ChefSpec::Coverage.report! }