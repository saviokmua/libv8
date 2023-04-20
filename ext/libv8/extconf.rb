require 'mkmf'
create_makefile('libv8')

require File.expand_path '../location', __FILE__
location = Libv8::Vendor.new

exit location.install!
