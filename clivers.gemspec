# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clivers/version'

Gem::Specification.new do |spec|
  spec.name          = "clivers"
  spec.version       = Clivers::VERSION
  spec.authors       = ["Matthieu Vachon"]
  spec.email         = ["matthieu.o.vachon@gmail.com"]
  spec.description   = "Command line tool versions manager"
  spec.summary       = <<-EOS
    This gem has been built to ease switching multiple versions
    of command line tools like Ruby, Python, Notepad++, etc. It
    is not installer, it's a tool to switch already installed
    software.

    By using a configuration file and some conventions, the
    tool will be able to locate your program and switch
    between multiple version of the same command line tool by
    tweaking the environment variables, usually simply the
    PATH one.
  EOS
  spec.homepage      = "https://github.com/maoueh/clivers"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/) - [".gitattributes", ".gitignore"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nugrant", "~>1.1.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
