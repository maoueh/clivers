require 'clivers/cli/clivers/set'
require 'clivers/cli/clivers/unset'
require 'clivers/cli/core/composite'
require 'clivers/version'

module Clivers
  module Cli
    module Clivers
      class Root < Core::Composite
        def name()
          "clivers"
        end

        def subcommands()
          {
            :set => Cli::Clivers::Set,
            :unset => Cli::Clivers::Unset,
          }
        end

        def options(parser)
          super(parser)
          parser.on_tail("-v", "--version", "Show version") do
            version()
          end
        end

        def version()
          puts ::Clivers::VERSION
          exit(0)
        end
      end
    end
  end
end