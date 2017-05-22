module MessageStore
  module Controls
    module MessageData
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

          message_data = MessageStore::MessageData::Write.build

          message_data.id = id
          message_data.type = type
          message_data.data = data
          message_data.metadata = metadata

          message_data
        end

        def self.id
          MessageData.id
        end

        def self.type
          MessageData.type
        end

        def self.data
          MessageData.data
        end

        def self.metadata
          MessageData::Metadata.data
        end
      end
    end
  end
end
