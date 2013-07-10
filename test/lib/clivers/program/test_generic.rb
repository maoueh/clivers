require 'test/unit'

require 'clivers/helper/environment'
require 'clivers/helper/path'
require 'clivers/program/generic'

module Clivers
  module Program
    class TestGeneric < Test::Unit::TestCase
      def get_base(name)
         File.expand_path("#{File.dirname(__FILE__)}/../../../resources/#{name}")
       end

      def get_generic(base, options = {})
        name = options.fetch(:name, "ruby")
        path = options.fetch(:path, base)
        executables = options.fetch(:executables, [".", "./bin", "/obj"])

        Program::Generic.new(name, :path => path, :executables => executables)
      end

      def get_path(base)
        Helper::Path.join(["C:/Python/3.2", "#{base}/1.9.3", "#{base}/1.9.3/bin", "#{base}/1.9.3/obj"])
      end

      def test_set()
        base = get_base("test_latest")
        path = get_path(base)
        generic = get_generic(base)

        Helper::Environment.stub(:PATH => path) do
          generic.set("1.8.7")
          assert_equal([
            "C:/Python/3.2",
            "#{base}/1.8.7",
            "#{base}/1.8.7/bin",
            "#{base}/1.8.7/obj",
          ], Helper::Path.split())
        end
      end
    end
  end
end
