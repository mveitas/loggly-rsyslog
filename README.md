[![Built on Travis](https://secure.travis-ci.org/mveitas/loggly-rsyslog.png?branch=master)](http://travis-ci.org/mveitas/loggly-rsyslog)

Loggly rsyslog Cookbook
================
Installs and configures rsyslog for use with [Loggly](http://loggly.com). This cookbook was built upon the work from an existing cookbook, https://github.com/kdaniels/loggly-rsyslog.

Requirements
------------
- Chef 11 or higher
- **Ruby 1.9.3 or higher**
- rsyslog is exists on the system

Platform
--------
Tested against Ubuntu 12.04

Data Bags
---------
This cookbook depends on the use of **encrypted data bags** to store the token to be used. For more information about data bags see the [Chef Data Bags](http://docs.opscode.com/essentials_data_bags.html) documentation. The data bag needs to be named `loggly` and contains an item `token`:

```
{
    "id": "token",
    "token": "<your token goes here>"
}
```

Attributes
----------
* `node['loggly']['tags']` - A list of event tags to apply to a message (https://www.loggly.com/docs/tags/) (optional)

* `node['loggly']['log_files']` - A list of files rsyslog should monitor. (optional). Below is an example
of a hash used to describe a file to monitor.

  ```
    {
        :filename => "/var/log/filename.log",
        :tag => "tag you want for this logfile",
        :statefile => "unique-name-for-statefile"
    }
    ```

* `node['loggly']['log_dirs']` - A list of directories to monitor (optional). The rsyslog.conf template will create an [imfile](http://www.rsyslog.com/doc/imfile.html) block for each file ending in '.log' in that directory. Each logdir in the list is of the format:
    ```
    {
        :directory => "/var/log/directory",
        :tag => "tag for all files in this directory"
    }
    ```

* `node['loggly']['tls']['enabled']` - Set to true if communication to the remote service should use TLS (defaults to true)
* `node['loggly']['tls']['cert_path']` - Directory where the loggly certificate should be placed
* `node['loggly']['tls']['cert_url']` - Url to the loggly.com certificate
* `node['loggly']['tls']['cert_checksum']` - Cchecksum of the loggly.com certificate
* `node['loggly']['tls']['intermediate_cert_url']` - Url to the intermediate certificate
* `node['loggly']['tls']['intermediate_cert_checksum']` - Checksum of the intermediate certificate

* `node['loggly']['rsyslog']['host']` - Name of the remote loggly syslog host
* `node['loggly']['rsyslog']['port']` - Port of the remote loggly syslog host (defaults to 514 and if TLS is enabled to 6514)

The following are attributes that manage some standard rsyslog configuration. See the rsyslog docs for more information on each of these.
* `node['loggly']['rsyslog']['repeat_msg']` - Set the RepeatedMsgReduction configuration value
* `node['loggly']['rsyslog']['file_owner']` - Set the FileOwnder configuration value
* `node['loggly']['rsyslog']['file_group']` - Set the FileGroup configuration value
* `node['loggly']['rsyslog']['file_create_mode']` - Set the FileCreateMode configuraton value
* `node['loggly']['rsyslog']['dir_create_mode']` - Set the DirCreateMode configuraton value
* `node['loggly']['rsyslog']['umask']` - Set the Umask configuration value
* `node['loggly']['rsyslog']['priv_drop_to_user']` - Set the PrivDropToUser configuration value
* `node['loggly']['rsyslog']['priv_drop_to_group']` - Set the PrivDropToGroup configuration value
* `node['loggly']['rsyslog']['work_directory']` - Set the WorkDirectory configuration value

Recipes
-------
Include the default recipe in the run list or a cookbook. The rsyslog service will restart after changes to the rsyslog.conf are made.

Running with Vagrant
--------------------
The create_data_bag.rb is a helper script that can be used to create the data bag for loggly for use with Vagrant and Chef Solo. The script expects a single arguement, the value of the loggly token.

Add the following two lines into your Vagrantfile in the chef_solo provisioner configuration:

```
chef.data_bags_path = './data_bags'
chef.encrypted_data_bag_secret_key_path = './encrypted_data_bag_secret'
```

License & Authors
-----------------
- Author: Matt Veitas <mveitas@gmail.com>

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

