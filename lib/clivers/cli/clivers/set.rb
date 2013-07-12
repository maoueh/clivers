require 'clivers/cli/core/base'

module Clivers
  module Cli
    module Clivers
      class Set < Core::Base
        def usage()
          "Usage: clivers #{name()} <program> <version>"
        end

        def description()
          <<-EOD
            This command will switch to the desired <version>
            of the <program>. If the <program> is not known
            to Clivers, an error will be displayed. If the
            <version> is not installed, an error will be
            displayed.

            Prior switching to <version>, the command will
            unset the previous program version, if present.
            If more than one version is detected as set, a
            warning is displayed and only the first one is
            unset.

            The programs are loaded from the ".clivers". See
            <> for more information.
          EOD
        end

        def execute()
          puts "Set"
        end
      end
    end
  end
end
