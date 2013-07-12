require 'clivers/cli/core/base'

module Clivers
  module Cli
    module Clivers
      class Unset < Core::Base
        def usage()
          "Usage: clivers #{name()} <program> (options)"
        end

        def description()
          <<-EOD
            This command unsets the previous program version, if
            present. If the <program> is not known to Clivers, an
            error will be displayed.

            If more than one version is detected as set, a
            warning is displayed and only the first one is
            unset. Use option `--all` to clear all version.

            The programs are loaded from the ".clivers". See
            <> for more information.
          EOD
        end

        def execute()
          puts "Unset"
        end
      end
    end
  end
end
