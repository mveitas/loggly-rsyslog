require 'rubygems'
require 'chef/encrypted_data_bag_item'

raise "Expecting loggly token as an argument" unless ARGV.length > 0

data_bag_secret = 'secret'
data = {
    'id' => 'token',
    'token' => ARGV[0]
}

encrypted_data = Chef::EncryptedDataBagItem.encrypt_data_bag_item(data, data_bag_secret)

File.open('./encrypted_data_bag_secret', 'w') do |f|
  f.print data_bag_secret
end

FileUtils.mkdir_p 'data_bags/loggly'
File.open('./data_bags/loggly/token.json', 'w') do |f|
  f.print encrypted_data.to_json
end

puts "Successfully created encrypted data bag files"