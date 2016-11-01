module EventSource
  module Controls
    module Read
      def self.example(stream: nil)
        stream ||= Stream.example
        Example.new(stream)
      end

      class Example
        include EventSource::Read
      end
    end
  end
end
