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
              position = items.length
            end
          end

          items = self.items

          if precedence == :desc
            items.sort! { |x, y| y.position <=> x.position }
          end

          index = (items.index { |i| i.position == position })

          return [] if index.nil?

          range = index..(index + batch_size - 1)

          items = items[range]

          items
        end
      end
    end
  end
end
