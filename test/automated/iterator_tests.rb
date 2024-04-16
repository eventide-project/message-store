require_relative './automated_init'

TestBench::Run.(
  'test/automated/iterator',
  exclude: '{_*,*sketch*,*_init,*_tests}.rb'
) or exit(false)
