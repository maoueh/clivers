require 'clivers'
require 'clivers/cli/core/base'
require 'clivers/program/factory'

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
          error("You must provide the <program> and the <version> arguments.") if @arguments.empty?()
          error("You must provide the <version> argument.") if @arguments.size() == 1
          error("The program [#{@arguments[0]}] is not present in `.clivers` file") if not known_program?(@arguments[0])

          @program = get_program(@arguments[0])
          @version = @arguments[1]

          @program.set(@version)
        rescue ArgumentError => exception
          error(exception.message)
        end

        def get_program(program)
          # TODO: This is probably killer to create all the programs because we need
          #       just one. For now, it will do the job.
          programs = Program::Factory.create_all(::Clivers.parameters())
          programs[program.to_sym()]
        end

        def known_program?(program)
          ::Clivers.parameters().has?(program.to_sym())
        end
      end
    end
  end
end
