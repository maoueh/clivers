require 'clivers'
require 'clivers/cli/core/base'
require 'clivers/program/factory'

module Clivers
  module Cli
    module Clivers
      class List < Core::Base
        def usage()
          "Usage: clivers #{name()} [<program> ...]"
        end

        def description()
          <<-EOD
            This command will list currently installed
            versions for the program passed in arguments.
            If there is no program received, will print
            version for each program known to Clivers.

            If you pass a program that is not known to
            Clivers, it will simply be skipped and nothing
            will be printed for this program.
          EOD
        end

        def execute()
          arguments = get_arguments()
          programs = get_programs()
          arguments.each do |argument|
            next if not known_program?(argument)

            puts ""
            puts "Program '#{argument}'"

            program = programs[argument.to_sym()]
            versions = program.list_versions()

            if versions.empty?()
              puts " No version installed"
              next
            end

            versions.each do |version|
              puts " #{version}"
            end
          end
        end

        def get_arguments()
          return @arguments if not @arguments.empty?()

          arguments = []
          ::Clivers.parameters().each do |key, value|
            arguments << key.to_s()
          end

          arguments
        end

        def get_programs()
          Program::Factory.create_all(::Clivers.parameters())
        end

        def known_program?(program)
          ::Clivers.parameters().has?(program.to_sym())
        end
      end
    end
  end
end
