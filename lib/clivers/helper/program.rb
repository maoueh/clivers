require 'mixlib/versioning'
require 'pathname'

module Clivers
  module Helper
    module Program
      @@RESOLVERS = {
        :latest => :resolve_latest,
      }

      ##
      # This function expects as fully expanded path
      # and will return the latest release version
      # of a program.
      #
      def self.resolve_latest(path)
        versions = Pathname.glob("#{path}/*").map { |i| i.basename.to_s }
        latest = Mixlib::Versioning.find_target_version(versions, nil, false, false)

        latest.to_s
      end

      ##
      # This function will resolve a symbolic version
      # into a real version. The path is required so
      # potential versions can be searched for and
      # resolved when symbolic version is used.
      #
      # If the version is an unhandled symbolic
      # version, an exception is raised.
      #
      # If the version is not a symbolic one, it
      # is immediately returned.
      def self.resolve(version, path)
        return version if not version.kind_of?(Symbol)

        resolver = @@RESOLVERS[version]
        raise ArgumentError, "Unknown symbolic version [#{version}]" unless resolver

        self.send(resolver, path)
      end
    end
  end
end
