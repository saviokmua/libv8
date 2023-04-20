module Libv8
  class System < Location
    def configure(context = MkmfContext.new)
      context.send(:dir_config, 'v8')
      context.send(:find_header, 'v8.h') or fail NotFoundError
      context.send(:find_header, 'libplatform/libplatform.h') or fail NotFoundError
      context.send(:have_library, 'v8') or fail NotFoundError
    end

    class NotFoundError < StandardError
      def initialize(*args)
        super(<<-EOS)
By using --with-system-v8, you have chosen to use the version
of V8 found on your system and *not* the one that is bundled with
the libv8 rubygem.

However, your system version of v8 could not be located.

Please make sure your system version of v8 that is compatible
with #{Libv8::VERSION} installed. You may need to use the
--with-v8-dir option if it is installed in a non-standard location
        EOS
      end
    end
  end
end