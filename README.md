[![Build Status](https://travis-ci.org/mveitas/loggly-rsyslog.svg?branch=master)](https://travis-ci.org/mveitas/loggly-rsyslog)

Loggly rsyslog Cookbook
================
Installs and configures rsyslog for use with [Loggly](http://loggly.com). This cookbook was built upon the work from an existing cookbook, https://github.com/kdaniels/loggly-rsyslog.

Requirements
------------
- Chef 11 or higher
- **Ruby 1.9.3 or higher**

Platform
--------
Tested against Ubuntu 12.04

Data Bags
---------
By default, this cookbook depends on the use of **encrypted data bags** to store the token to be used. For more information about data bags see the [Chef Data Bags](http://docs.opscode.com/essentials_data_bags.html) documentation. By default, the data bag needs to be named `loggly` and contains an item `token`:

```
{
    "id": "token",
    "token": "<your token goes here>"
}
```
You may change the name of the data bag and item via the `node['loggly']['token']['databag']` and `node['loggly']['token']['databag_item']` attributes respectively.
Also, if you do not want this cookbook to load the credentials for you, and instead want to set them yourself, set `node['loggly']['token']['from_databag']` to `false`, and then set the credentials via `node['loggly']['token']['value']`.


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

* `node['loggly']['log_dirs']` - A list of directories to monitor (optional). The loggly configuration template will create an [imfile](http://www.rsyslog.com/doc/imfile.html) block for each file ending in '.log' in that directory. Each logdir in the list is of the format:
    ```
    {
        :directory => "/var/log/directory",
        :tag => "tag for all files in this directory"
    }
    ```

* `node['loggly']['tls']['enabled']` - Set to true if communication to the remote service should use TLS (defaults to true)
* `node['loggly']['tls']['cert_path']` - Directory where the loggly certificate should be placed
* `node['loggly']['tls']['cert_url']` - Url to the loggly.com certificate
* `node['loggly']['tls']['cert_checksum']` - Checksum of the loggly.com certificate
* `node['loggly']['tls']['intermediate_cert_url']` - Url to the intermediate certificate
* `node['loggly']['tls']['intermediate_cert_checksum']` - Checksum of the intermediate certificate

* `default['loggly']['token']['from_databag']` - Whether to load the Loggly token from a Data Bag (defaults to true)
* `default['loggly']['token']['databag']` - The name of the Data Bag to load the credentials from (defaults to "loggly")
* `default['loggly']['token']['databag_item']` - The name of the Data Bag Item to load the credentials from (defaults to "token")
* `default['loggly']['token']['value']` - The Loggly token. Set from the Data Bag above by default.

* `node['loggly']['rsyslog']['conf']` - Name of the loggly rsyslog configuration file (defaults to /etc/rsyslog.d/10-loggly.conf)
* `node['loggly']['rsyslog']['host']` - Name of the remote loggly syslog host (defaults to logs-01.loggly.com)
* `node['loggly']['rsyslog']['port']` - Port of the remote loggly syslog host (defaults to 514 and if TLS is enabled to 6514)
* `node['loggly']['rsyslog']['input_file_poll_interval']` - Specifies how often files are to be polled for new data (defaults to 10)

Recipes
-------
Include the default recipe in the run list or a cookbook. The cookbook includes the rsyslog cookbook that will install the rsyslog package and start the service if it does not exist. The rsyslog service will restart after changes to the loggly rsyslog configuration file are made.

Running Locally with Vagrant
----------------------------
Since the cookbook relies on using an encrypted data bag, there is some additional steps that are needed in order to run the cookbook locally using Vagrant. The create_data_bag.rb is a helper script that can be used to create the data bag for loggly for use with Vagrant and Chef Solo. The script expects a single argument, the value of the loggly token.

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

