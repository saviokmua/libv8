module Libv8
  class Vendor < Location
    def install!
      require File.expand_path '../builder', __FILE__
      builder = Libv8::Builder.new
      exit_status = builder.build_libv8!
      super if exit_status == 0
      verify_installation!
      return exit_status
    end

    def configure(context = MkmfContext.new)
      context.incflags.insert 0, Libv8::Paths.include_paths.map { |p| "-I#{p}" }.join(" ") + " "
      context.ldflags.insert 0, Libv8::Paths.object_paths.join(" ") + " "
    end

    def verify_installation!
      include_paths = Libv8::Paths.include_paths
      unless include_paths.detect { |p| Pathname(p).join('v8.h').exist? }
        fail HeaderNotFound, "Unable to locate 'v8.h' in the libv8 header paths: #{include_paths.inspect}"
      end
      Libv8::Paths.object_paths.each do |p|
        fail ArchiveNotFound, p unless File.exist? p
      end
    end

    class HeaderNotFound < StandardError; end

    class ArchiveNotFound < StandardError
      def initialize(filename)
        super "libv8 did not install properly, expected binary v8 archive '#{filename}'to exist, but it was not found"
      end
    end
  end
end