module EventSource
  module Controls
    module EventData
      module Read
        def self.example(id: nil, type: nil, data: nil, metadata: nil)
          if id == :none
            id = nil
          else
            id ||= self.id
          end

          type ||= self.type

          if data == :none
            data = nil
          else
            data ||= self.data
          end

          if metadata == :none
            metadata = nil
          else
            metadata ||= self.metadata
          end

          event_data = EventSource::EventData::Read.build

          event_data.id = id
          event_data.type = type
          event_data.data = data
          event_data.metadata = metadata
          event_data.position = position
          event_data.global_position = global_position
          event_data.time = time
          event_data.stream_name = stream_name

          event_data
        end

        def self.id
          EventData.id
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

        def self.time
          Time::Raw.example
        end

        def self.stream_name
          StreamName.example
        end
      end
    end
  end
end
