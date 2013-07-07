require 'test/unit'
require 'clivers/helper/path'

module Clivers
  module Helper
    class TestPath < Test::Unit::TestCase
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
    end
  end
end
