require 'nugrant/parameters'

module Clivers
  module Program
    module Factory
      def self.create(name, options)
        errors = validate(name, options)
        # TODO: Log errors somewhere
        return if errors

        # TODO: Build specific program when checking in name
        Program::Generic.new(name, options)
      end

      def self.create_all(input)
        programs = case
          when input.kind_of?(Nugrant::Parameters)
            input.__to_hash()
          else
            input
        end

        programs.map do |name, options|
          create(name, options)
        end
      end

      def self.validate(name, options)
        errors = []

        errors << "Name must not be nil." if not name
        errors << "Option 'path' is missing for program [#{name}]." if not options[:path]
        options.each do |key, value|
          errors << "Unknown option [#{key}] for program [#{name}]." if not [:path, :executables].include?(key)
        end

        errors == [] ? nil : errors
      end
    end
  end
end
