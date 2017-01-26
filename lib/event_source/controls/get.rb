module EventSource
  module Controls
    module Get
      def self.example(batch_size: nil, count: nil, global_position_offset: nil)
        batch_size ||= 1
        count ||= 1
        global_position_offset ||= -> (x) { x ** 2 }

        get = EventSource::Get::Substitute.build(batch_size: batch_size)

        elements = (0..(count - 1)).to_a

        elements.each do |e|
          event_data = EventData::Read.example
          event_data.position = e
          event_data.global_position = global_position_offset.(event_data.position)

          get.items << event_data
        end

        get
      end
    end
  end
end
