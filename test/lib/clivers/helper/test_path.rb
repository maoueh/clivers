require 'test/unit'
require 'clivers/helper/path'

module Clivers
  module Helper
    class TestPath < Test::Unit::TestCase
      def test_append()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\"
        ) do
          Helper::Path.append("C:\\Ruby\\append")
          assert_equal([
            "C:/Ruby/1.9.3",
            "C:\\Ruby\\bin\\1.8.7\\",
            "C:\\Ruby\\append",
          ], Helper::Path.split())
        end
      end

      def test_find()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:/Ruby/1.9.3/bin;C:/Windows/bin/C:/Gnu/bin"
        ) do
          assert_equal([
            "C:/Ruby/1.9.3",
            "C:/Ruby/1.9.3/bin"
          ], Helper::Path.find(/^C:\/Ruby\/1.9.3/))
        end

        Helper::Environment.stub(
          :PATH => "C:\\Ruby\\1.9.3\\bin;C:\\Windows\\bin\\;C:\\Gnu\\bin"
        ) do
          assert_equal(["C:\\Ruby\\1.9.3\\bin"], Helper::Path.find(/^C:\/Ruby\/1.9.3/))
        end
      end

      def test_join()
        # FIXME: Test will fail on non windows platform
        assert_equal("C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\", Helper::Path.join(["C:/Ruby/1.9.3","C:\\Ruby\\bin\\1.8.7\\"]))
      end

      def test_parse()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\"
        ) do
          parsed = Helper::Path.parse()
          assert_equal({
            "C:/Ruby/1.9.3" => "C:/Ruby/1.9.3",
            "C:/Ruby/bin/1.8.7" => "C:\\Ruby\\bin\\1.8.7\\",
          }, parsed)
        end
      end

      def test_prepend()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\"
        ) do
          Helper::Path.prepend("C:\\Ruby\\append")
          assert_equal([
            "C:\\Ruby\\append",
            "C:/Ruby/1.9.3",
            "C:\\Ruby\\bin\\1.8.7\\",
          ], Helper::Path.split())
        end
      end

      def test_split()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\"
        ) do
          assert_equal([
            "C:/Ruby/1.9.3",
            "C:\\Ruby\\bin\\1.8.7\\",
          ], Helper::Path.split())
        end
      end

      def test_remove()
        Helper::Environment.stub(
          :PATH => "C:/Ruby/1.9.3;C:\\Ruby\\bin\\1.8.7\\"
        ) do
          Helper::Path.remove("C:\\Ruby\\bin\\1.8.7\\")
          assert_equal([
            "C:/Ruby/1.9.3"
          ], Helper::Path.split())
        end
      end
    end
  end
end
