module EventSource
  module Controls
    module EventData
      module Write
        def self.example(type: nil, data: nil, metadata: nil)
          type ||= self.type
          data ||= self.data
          metadata ||= self.metadata

          event_data = EventSource::EventData::Write.build

          event_data.type = type
          event_data.data = data
          event_data.metadata = metadata

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
      end
    end
  end
end
