require 'nugrant/parameters'
require 'test/unit'
require 'tmpdir'

require 'clivers/program/factory'

module Clivers
  module Program
    class TestFactory < Test::Unit::TestCase
      def create_parameters()
        resource_path = File.expand_path("#{File.dirname(__FILE__)}/../../../resources/test_parameters")

        return Nugrant::Parameters.new({
          :config => {
            :format => :yaml,
            :user_path => "#{resource_path}/clivers.yml",
          },
        })
      end

      def test_validate_name_nil()
        expected_errors = ["Name must not be nil."]
        actual_errors = Factory.validate(nil, {:path => "any"})

        assert_equal(expected_errors, actual_errors)
      end

      def test_validate_no_path()
        expected_errors = ["Option 'path' is missing for program [ruby]."]
        actual_errors = Factory.validate("ruby", {:executables => "./bin"})

        assert_equal(expected_errors, actual_errors)
      end

      def test_validate_invalid_option()
        expected_errors = ["Unknown option [invalid] for program [ruby]."]
        actual_errors = Factory.validate("ruby", {:path => "any", :invalid => "./bin"})

        assert_equal(expected_errors, actual_errors)
      end

      ##
      # This test at the same time the create() method
      #
      def test_create_all()
        tmp_path = Dir.tmpdir()

        input = {
          :ruby => {
            :path => "#{tmp_path}/ruby",
            :executables => "./bin",
          },
          :python => {
            :path => "#{tmp_path}/python",
          },
          :java => {
            :path => "#{tmp_path}/java",
            :executables => ["./obj", "./lib"],
          },
        }
        programs = Factory.create_all(input)

        assert_equal(3, programs.size())

        program0 = programs[:ruby]
        assert_equal("ruby", program0.name)
        assert_equal("#{tmp_path}/ruby", program0.path)
        assert_equal(["./bin"], program0.executables)

        program1 = programs[:python]
        assert_equal("python", program1.name)
        assert_equal("#{tmp_path}/python", program1.path)
        assert_equal(["."], program1.executables)

        program2 = programs[:java]
        assert_equal("java", program2.name)
        assert_equal("#{tmp_path}/java", program2.path)
        assert_equal(["./obj", "./lib"], program2.executables)
      end

      ##
      # This test at the same time the create() method
      #
      def test_create_all_parameters()
        parameters = create_parameters()
        programs = Factory.create_all(parameters)

        current_path = Dir.getwd()
        assert_equal(3, programs.size())

        program0 = programs[:ruby]
        assert_equal("ruby", program0.name)
        assert_equal("#{current_path}/ruby", program0.path)
        assert_equal(["./bin"], program0.executables)

        program1 = programs[:python]
        assert_equal("python", program1.name)
        assert_equal("#{current_path}/python", program1.path)
        assert_equal(["."], program1.executables)

        program2 = programs[:java]
        assert_equal("java", program2.name)
        assert_equal("#{current_path}/java", program2.path)
        assert_equal(["./obj", "./lib"], program2.executables)
      end
    end
  end
end
