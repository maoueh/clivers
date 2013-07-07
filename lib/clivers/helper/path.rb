module Clivers
  module Helper
    module Path
      ##
      # Returns all path elements that match the regex
      # received in arguments.
      #
      # To ensure consistencies with the two different
      # ways to write path on Windows (with / or with \\),
      # the search is performed on the canonicalize form
      # of the path element but the original one is returned.
      #
      def self.find(regex)
        parsed = parse()
        parsed.select do |key, value|
          key =~ regex
        end.values()
      end

      ##
      # Returns all the paths elements, split using
      # the right separator for the platform
      #
      def self.split()
        ENV['PATH'].split(separator())
      end

      ##
      # Return the separator that should be used to
      # split the path elements depending on the
      # current platform.
      #
      def self.separator()
        # TODO: Find right separator depending on the platform
        separator = ";"
      end

      ##
      # Parse the ENV['PATH'] environment and returned
      # a hash where the key is the canonicalize form
      # of the path the value is the original path form.
      #
      def self.parse()
        Hash[split().map do |element|
          [Helper::Pathname.canonicalize(element), element]
        end]
      end
    end
  end
end
