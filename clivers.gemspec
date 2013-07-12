# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clivers/version'

Gem::Specification.new do |gem|
  gem.name          = "clivers"
  gem.version       = Clivers::VERSION
  gem.authors       = ["Matthieu Vachon"]
  gem.email         = ["matthieu.o.vachon@gmail.com"]
  gem.summary       = "Command line tool versions manager"
  gem.description = <<-EOS
    This gem has been built to ease usage of multiple versions
    of command line tools like Ruby, Python, Vagrant, etc. It
    is not installer, it's a tool to switch between already
    installed versions of a software.

    By using a configuration file and some conventions, the
    tool will be able to locate your program and switch
    between multiple version of  it be tweaking your
    environment variables, usually simply the PATH one.
  EOS

  gem.homepage      = "https://github.com/maoueh/clivers"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/) - [".gitattributes", ".gitignore"]
  gem.executables   = gem.files.grep(%r{^bin/}) { |file| File.basename(file) }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "mixlib-versioning", "~>1.0.0"
  gem.add_dependency "nugrant", "2.0.0.dev2"

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end
