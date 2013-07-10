require 'clivers/helper/path'
require 'clivers/helper/pathname'
require 'clivers/helper/program'

module Clivers
  module Program
    class Generic
      def initialize(name, options = {})
        @name = name
        @path = Helper::Pathname.canonicalize(options.fetch(:path))
        @executables = options.fetch(:executables, ["."])
      end

      def set(version = :latest)
        unset(:current)

        version = Helper::Program.resolve(version, @path)
        raise ArgumentError, "Version [#{version}] is not installed" unless File.exists?("#{@path}/#{version}")

        set_path(version)
      end

      def unset(version = :current)
        version = Helper::Program.resolve(version, @path)
        return false if not version

        if version.kind_of?(Array)
          # FIXME: Log warning messages somewhere
          #log("There is multiple versions currently set, only unsetting version [#{version[0]}]")
          #version.each do |value|
          #  log(" Found version #{value}")
          #end
          version = version[0]
        end

        unset_path(version)
      end

      def set_path(version)
        location = "#{@path}/#{version}"
        @executables.each do |executable|
          entry = resolve_executable(executable, location)
          if not entry.start_with?(location)
            entry = Helper::Pathname.canonicalize("#{location}/#{executable}")
          end

          # TODO: Make it configurable to prepend or append
          Helper::Path.append(entry)
        end
      end

      def unset_path(version)
        regex = "^#{Regexp.quote("#{@path}/#{version}")}"
        Helper::Path.find(/#{regex}/).each do |entry|
          Helper::Path.remove(entry)
        end
      end

      def resolve_executable(executable, location)
        Helper::Pathname.canonicalize(executable.sub(".", location))
      end
    end
  end
end
