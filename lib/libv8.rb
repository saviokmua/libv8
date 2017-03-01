require 'libv8/version'
require 'libv8/location'
require 'libv8/vendor'
require 'libv8/system'

module Libv8
  def self.configure_makefile
    location = Location.load!
    location.configure
  end
end
