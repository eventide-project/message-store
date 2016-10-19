# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'event_source'
  s.version = '0.2.0.0'
  s.summary = 'Common primitives for event source clients'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/event-source'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'casing'
  s.add_runtime_dependency 'schema'
  s.add_runtime_dependency 'initializer'
  s.add_runtime_dependency 'identifier-uuid'
  s.add_runtime_dependency 'serialize'

  s.add_development_dependency 'test_bench'
end
