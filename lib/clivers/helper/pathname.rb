module Clivers
  module Helper
    module Pathname
      # TODO: Maybe we should instead add functions found in
      #       this module to Ruby Pathname directly...

      ##
      # Transform a path into a canonical form.
      # This is primarily used to ensure that
      # the two possible path forms on Windows
      # can be determined as identical.
      def self.canonicalize(path)
        File.expand_path(path).gsub("\\", "/").chomp("/")
      end
    end
  end
end
