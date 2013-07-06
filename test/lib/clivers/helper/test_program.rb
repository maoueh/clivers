require 'test/unit'
require 'clivers/helper/program'

module Clivers
  module Helper
    class TestProgram < Test::Unit::TestCase
    def get_test_path(name)
      File.expand_path("#{File.dirname(__FILE__)}/../../../resources/#{name}")
    end

    def test_resolve()
      path = get_test_path("test_latest")
      assert_equal(Helper::Program.resolve(:latest, path), "1.9.3")
    end

    def test_resolve_not_symbolic_version()
      path = get_test_path("test_latest")

      assert_equal(Helper::Program.resolve("11.9.2", path), "11.9.2")
    end

    def test_resolve_invalid_symbolic_version()
      path = get_test_path("test_latest")

      assert_raise(ArgumentError) do
        Helper::Program.resolve(:unknow, path)
      end
    end

    def test_resolve_latest()
      path = get_test_path("test_latest")

      assert_equal(Helper::Program.resolve_latest(path), "1.9.3")
    end
    end
  end
end
