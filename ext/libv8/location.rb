require 'yaml'
require 'pathname'
require File.expand_path '../paths', __FILE__

module Libv8
  class Location
    def install!
      File.open(Pathname(__FILE__).dirname.join('.location.yml'), "w") do |f|
        f.write self.to_yaml
      end
      return 0
    end

    def self.load!
      File.open(Pathname(__FILE__).dirname.join('.location.yml')) do |f|
        YAML.load f
      end
    end

    class MkmfContext
      def incflags
        $INCFLAGS
      end

      def ldflags
        $LDFLAGS
      end
    end
  end
end
