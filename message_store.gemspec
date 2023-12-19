# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-message_store'
  s.version = '2.4.0.0'
  s.summary = 'Common primitives for platform-specific message store implementations'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/message-store'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'evt-settings'
  s.add_runtime_dependency 'evt-casing'
  s.add_runtime_dependency 'evt-schema'
  s.add_runtime_dependency 'evt-initializer'
  s.add_runtime_dependency 'evt-identifier-uuid'
  s.add_runtime_dependency 'evt-transform'
  s.add_runtime_dependency 'evt-virtual'
  s.add_runtime_dependency 'evt-async_invocation'

  s.add_development_dependency 'test_bench'
end
