require 'test/unit'
require 'clivers/helper/environment'
require 'clivers/helper/program'

module Clivers
  module Helper
    class TestProgram < Test::Unit::TestCase
      def get_test_path(name)
        File.expand_path("#{File.dirname(__FILE__)}/../../../resources/#{name}")
      end

      def test_resolve()
        path = get_test_path("test_latest")
        assert_equal("1.9.3", Helper::Program.resolve(:latest, path))

        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\1.9.3"
        ) do
          assert_equal("1.9.3", Helper::Program.resolve(:current, "C:/Ruby"))
        end
      end

      def test_resolve_not_symbolic_version()
        path = get_test_path("test_latest")

        assert_equal("11.9.2", Helper::Program.resolve("11.9.2", path))
      end

      def test_resolve_invalid_symbolic_version()
        path = get_test_path("test_latest")

        assert_raise(ArgumentError) do
          Helper::Program.resolve(:unknow, path)
        end
      end

      def test_resolve_latest()
        path = get_test_path("test_latest")

        assert_equal("1.9.3", Helper::Program.resolve_latest(path))
      end

      def test_resolve_no_latest()
        path = get_test_path("test_empty")

        assert_equal(nil, Helper::Program.resolve_latest(path))
      end

      def test_current()
        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\1.9.3;C:\\Ruby\\1.9.3\\bin"
        ) do
          assert_equal("1.9.3", Helper::Program.resolve_current("C:/Ruby"))
        end
      end

      def test_current_invalid()
        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\binary;"
        ) do
          assert_equal(nil, Helper::Program.resolve_current("C:/Ruby"))
        end
      end

      def test_current_with_some_invalid()
        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\bin;C:\\Ruby\\1.9.3\\bin"
        ) do
          assert_equal("1.9.3", Helper::Program.resolve_current("C:/Ruby"))
        end
      end

      def test_current_multiple()
        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\bin;C:\\Ruby\\1.9.3\\bin;C:\\Ruby\\1.8.7\\bin;C:\\Ruby\\1.8.5\\"
        ) do
          assert_equal(["1.9.3", "1.8.7", "1.8.5"], Helper::Program.resolve_current("C:/Ruby"))
        end
      end
    end
  end
end
