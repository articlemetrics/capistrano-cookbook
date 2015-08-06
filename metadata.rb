name              "capistrano"
maintainer        "Martin Fenner"
maintainer_email  "mfenner@plos.org"
license           "Apache 2.0"
description       "Capistramo configuration"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.10.11"
depends           "ruby", "~> 0.7.0"
depends           "nodejs"
depends           "consul"
depends           "remote_syslog2"

%w{ ubuntu }.each do |platform|
  supports platform
end
