require 'mkmf'
create_makefile('libv8')

require File.expand_path '../location', __FILE__
require File.expand_path '../vendor', __FILE__
require File.expand_path '../system', __FILE__

location = with_config('system-v8') ? Libv8::System.new : Libv8::Vendor.new

exit location.install!
