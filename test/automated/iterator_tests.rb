require_relative 'automated_init.rb'

TestBench::Runner.(
  'iterator/**/*.rb',
  exclude_pattern: %r{\/_|sketch|(_init\.rb|_tests\.rb)\z}
) or exit 1
