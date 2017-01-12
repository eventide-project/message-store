module EventSource
  module Controls
    module EventData
      module Write
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

          event_data = EventSource::EventData::Write.build

          event_data.id = id
          event_data.type = type
          event_data.data = data
          event_data.metadata = metadata

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
      end
    end
  end
end
