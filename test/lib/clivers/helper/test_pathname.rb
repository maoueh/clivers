require 'test/unit'
require 'clivers/helper/pathname'

module Clivers
  module Helper
    class TestPathname < Test::Unit::TestCase
      def test_simple()
        assert_equal("C:/Ruby/bin/1.8.7", Helper::Pathname.canonicalize("C:\\Ruby\\bin\\1.8.7\\"))
      end
    end
  end
end
