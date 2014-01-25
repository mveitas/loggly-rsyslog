Loggly rsyslog Cookbook
================
Installs and configures rsyslog for use with [Loggly](http://loggly.com). This cookbook was built upon the work from an existing cookbook,
https://github.com/kdaniels/loggly-rsyslog.

Requirements
------------
- Chef 11 or higher
- **Ruby 1.9.3 or higher**
- rsyslog is exists on the system

Platform
--------
Tested against Ubuntu 12.04


Attributes
----------
* `node['loggly']['token']` - Your Loggly customer token (required)
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

* `node['loggly']['logdirs']` - A list of directories to monitor (optional). The rsyslog.conf template will create an [imfile](http://www.rsyslog.com/doc/imfile.html) block for each file ending in '.log' in that directory. Each logdir in the list is of the format:
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

Recipes
-------
Include the default recipe in the run list or a cookbook. The rsyslog service will restart after changes to the rsyslog.conf are made.


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

