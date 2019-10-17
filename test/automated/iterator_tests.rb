require_relative './automated_init'

TestBench::CLI::Run.(
  'test/automated/iterator',
  exclude_file_pattern: %r{/_|sketch|(_init\.rb|_tests\.rb)\z}
)
