ENV['TEST_BENCH_EXCLUDE_PATTERN'] ||= '/_|sketch|(_init\.rb|_tests\.rb)\z'

require_relative './automated_init'

TestBench::CLI::Run.('test/automated/iterator')
