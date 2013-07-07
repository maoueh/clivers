module Clivers
  module Helper
    module Environment
      def self.replace(variables)
        ENV.clear()

        variables = Hash[variables.map do |name, value|
          [name.to_s, value]
        end]

        ENV.update(variables)
      end

      def self.stub(new = {})
        old = ENV.to_hash()

        Helper::Environment.replace(new)
        yield
        Helper::Environment.replace(old)
      end
    end
  end
end
