module MessageStore
  module Controls
    module Get
      def self.example(stream_name: nil, batch_size: nil, count: nil, global_position_offset: nil)
        stream_name ||= StreamName.example
        batch_size ||= 1
        count ||= 1
        global_position_offset ||= -> (x) { x ** 2 }

        get = MessageStore::Get::Substitute.build
        get.stream_name = stream_name
        get.batch_size = batch_size

        elements = (0..(count - 1)).to_a

        elements.each do |e|
          message_data = MessageData::Read.example
          message_data.position = e
          message_data.global_position = global_position_offset.(message_data.position)

          get.items << message_data
        end

        get
      end
    end
  end
end
