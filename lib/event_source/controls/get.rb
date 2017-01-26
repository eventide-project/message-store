module EventSource
  module Controls
    module Get
      def self.example(batch_size: nil, count: nil)
        batch_size ||= 1
        count ||= 1

        get = Example.build(batch_size: batch_size)

        elements = (0..(count - 1)).to_a

        elements.each do |e|
          event_data = EventData::Read.example
          event_data.position = e
          event_data.global_position = 2 + e ** 2

          get.items << event_data
        end

        get
      end

      class Example
        include Log::Dependency

        initializer na(:batch_size)

        def batch_size
          @batch_size ||= 1
        end

        def items
          @items ||= []
        end

        def self.build(batch_size: nil, session: nil)
          new(batch_size)
        end

        def call(stream_name=nil, position: nil)
          position ||= 0

          logger.trace(tag: :control) { "Getting (Position: #{position}, Batch Size: #{batch_size}, Stream Name: #{stream_name.inspect})" }

          logger.debug(tags: [:control, :data]) { "Items: \n#{items.pretty_inspect}" }
          logger.debug(tag: :control) { "Position: #{position.inspect}" }
          logger.debug(tag: :control) { "Batch Size: #{batch_size.inspect}" }

          unless EventSource::StreamName.category?(stream_name)
            index = (items.index { |i| i.position >= position })
          else
            index = (items.index { |i| i.global_position >= position })
          end

          logger.debug(tag: :control) { "Index: #{index.inspect}" }

          if index.nil?
            items = []
          else
            range = index..(index + batch_size - 1)
            logger.debug(tag: :control) { "Range: #{range.pretty_inspect}" }

            items = self.items[range]
          end

          logger.info(tags: [:control, :data]) { "Got: \n#{items.pretty_inspect}" }
          logger.info(tag: :control) { "Finished getting (Position: #{position}, Stream Name: #{stream_name.inspect})" }

          items
        end
      end
    end
  end
end
