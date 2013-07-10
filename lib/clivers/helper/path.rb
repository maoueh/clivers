module Clivers
  module Helper
    module Path
      ##
      # Append a new entry at the end of the
      # of the current PATH entries.
      #
      def self.append(entry)
        entries = split() + [entry]

        ENV['PATH'] = entries.join(separator())
      end

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
        entries = parse()
        entries.select do |key, value|
          key =~ regex
        end.values()
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

      ##
      # Prepend a new entry at the front of the
      # of the current PATH entries.
      #
      def self.prepend(entry)
        entries = [entry] + split()

        ENV['PATH'] = entries.join(separator())
      end

      ##
      # Returns all the paths elements, split using
      # the right separator for the platform
      #
      def self.split()
        ENV['PATH'].split(separator())
      end

      ##
      # Join the received entries with the right
      # separator for the current platform and return
      # the result.
      #
      def self.join(entries)
        entries.join(separator())
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
      # Remove the current entry from the PATH. The entry
      # must be an exact match to be removed.
      #
      def self.remove(entry)
        entries = split()
        entries.select! do |value|
          value != entry
        end

        ENV['PATH'] = entries.join(separator())
      end
    end
  end
end
