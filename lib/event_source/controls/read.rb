module EventSource
  module Controls
    module Read
      def self.example(stream_name: nil)
        stream_name ||= StreamName.example
        Example.new(stream_name)
      end

      class Example
        include EventSource::Read
      end
    end
  end
end
