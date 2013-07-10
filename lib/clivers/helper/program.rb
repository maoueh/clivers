require 'mixlib/versioning'
require 'pathname'
require 'set'

require 'clivers/helper/path'
require 'clivers/helper/pathname'

module Clivers
  module Helper
    module Program
      @@RESOLVERS = {
        :current => :resolve_current,
        :latest => :resolve_latest,
      }

      ##
      # This function expects as fully expanded path
      # and will return the latest release version
      # of a program that is found within this path.
      #
      # It expects a fully canonicalize path, i.e.
      # a path with only forward slashes and not trailing
      # slashes.
      #
      def self.resolve_current(path)
        regex = "^#{Regexp.quote(path)}"
        versions = Helper::Path.find(/#{regex}/).map do |element|
          element = Helper::Pathname.canonicalize(element).gsub("#{path}/", "")
          slash_index = element.index("/")
          version = slash_index ? element[0..slash_index - 1] : element

          Mixlib::Versioning.parse(version)
        end.to_set().to_a()

        versions.select! do |version|
          version != nil
        end

        return nil if versions.size() == 0
        return versions[0].to_s() if versions.size() == 1

        versions.map! { |version| version.to_s() }
      end

      ##
      # This function expects as fully expanded path
      # and will return the latest release version
      # of a program that is found within this path.
      #
      def self.resolve_latest(path)
        versions = ::Pathname.glob("#{path}/*").map { |i| i.basename.to_s }
        latest = Mixlib::Versioning.find_target_version(versions, nil, false, false)

        # Return nil if latest was nil, to string otherwise
        latest && latest.to_s
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
