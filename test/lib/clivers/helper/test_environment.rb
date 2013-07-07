require 'test/unit'

require 'clivers/helper/environment'

module Clivers
  module Helper
    class TestEnvironment < Test::Unit::TestCase
      def test_stub()
        old = ENV.to_hash()

        Helper::Environment.stub(
          :NEW => "value"
        ) do
          assert_equal({"NEW" => "value"}, ENV.to_hash())
        end

        assert_equal(old, ENV.to_hash())
      end
    end
  end
end
