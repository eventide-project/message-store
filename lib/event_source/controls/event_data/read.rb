module EventSource
  module Controls
    module EventData
      module Read
        def self.example(type: nil, data: nil, metadata: nil)
          type ||= self.type
          data ||= self.data
          metadata ||= self.metadata

          event_data = EventSource::EventData::Read.build

          event_data.type = type
          event_data.data = data
          event_data.metadata = metadata
          event_data.position = position
          event_data.global_position = global_position
          event_data.recorded_time = recorded_time
          event_data.stream_name = stream_name

          event_data
        end

        def self.type
          EventData.type
        end

        def self.data
          EventData.data
        end

        def self.metadata
          EventData::Metadata.data
        end

        def self.position
          1
        end

        def self.global_position
          111
        end

        def self.recorded_time
          Time::Raw.example
        end

        def self.stream_name
          StreamName.example
        end
      end
    end
  end
end
