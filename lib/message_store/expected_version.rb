module MessageStore
  module ExpectedVersion
    class Error < RuntimeError; end

    def self.canonize(expected_version)
      return nil if expected_version.nil?
      return expected_version unless expected_version == NoStream.name
      NoStream.version
    end
  end
end
