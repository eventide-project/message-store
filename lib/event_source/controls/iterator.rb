module EventSource
  module Controls
    module Iterator
      def self.example(stream_name: nil, position: nil)
        stream_name ||= StreamName.example
        Example.build(stream_name, position: position)
      end

      class Example
        include EventSource::Read::Iterator

        def last_position
          unless EventSource::StreamName.category?(stream_name)
            batch.last.position
          else
            batch.last.global_position
          end
        end
      end
    end
  end
end
