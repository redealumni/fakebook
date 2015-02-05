lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fakebook/version'

Gem::Specification.new do |spec|
  spec.name          = 'fakebook'
  spec.version       = Fakebook::VERSION
  spec.authors       = ['Dalton Pinto']
  spec.email         = ['dalton@redealumni.com']
  spec.description   = %q{Facebook OAuth sandbox to help development process}
  spec.summary       = %q{Facebook OAuth Sandbox for Developers}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = Dir['{bin,lib,test,spec}/**/*'] + ['fakebook.gemspec', 'LICENSE.txt', 'Rakefile', 'Gemfile', 'README.mdown']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }

  spec.require_paths = ['lib']

  spec.add_dependency 'sinatra'
  spec.add_dependency 'omniauth'
  spec.add_dependency 'omniauth-facebook'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
