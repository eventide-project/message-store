module EventSource
  module Controls
    module Get
      def self.example(precedence: nil, batch_size: nil, count: nil)
        precedence ||= :asc
        batch_size ||= 1
        count ||= 1

        get = Example.build(batch_size: batch_size, precedence: precedence)

        elements = (0..(count - 1)).to_a
        elements.reverse! if precedence == :desc

        elements.each do |e|
          event_data = EventData::Read.example
          event_data.position = e
          event_data.global_position = e

          get.items << event_data
        end

        get
      end

      class Example
        include Log::Dependency

        initializer na(:batch_size), na(:precedence)

        def batch_size
          @batch_size ||= 1
        end

        def precedence
          @precedence ||= :asc
        end

        def items
          @items ||= []
        end

        def self.build(batch_size: nil, precedence: nil, session: nil)
          new(batch_size, precedence)
        end

        def call(stream_name=nil, position: nil)
          if position.nil?
            if precedence == :asc
              position = 0
            else
              position = items.length - 1
            end
          end

          logger.trace(tag: :control) { "Getting (Position: #{position}, Batch Size: #{batch_size}, Precedence: #{precedence}, Stream Name: #{stream_name.inspect})" }

          items = self.items

          if precedence == :desc
            items.sort! { |x, y| y.position <=> x.position }
          end

          # logger.debug(tags: [:control, :data]) { "Items: \n#{items.pretty_inspect}" }
          logger.debug(tag: :control) { "Position: #{position.inspect}" }
          logger.debug(tag: :control) { "Batch Size: #{batch_size.inspect}" }

          index = (items.index { |i| i.position == position })
          logger.debug(tag: :control) { "Index: #{index.inspect}" }

          if index.nil?
            items = []
          else
            range = index..(index + batch_size - 1)
            logger.debug(tag: :control) { "Range: #{range.pretty_inspect}" }

            items = items[range]
          end

          logger.info(tags: [:control, :data]) { "Got: \n#{items.pretty_inspect}" }
          logger.info(tag: :control) { "Finished getting (Position: #{position}, Precedence: #{precedence}, Stream Name: #{stream_name.inspect})" }

          items
        end
      end
    end
  end
end
