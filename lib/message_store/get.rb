module MessageStore
  module Get
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        abstract :call
      end
    end

    class Substitute
      include Get

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

        unless self.class.category?(stream_name)
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

      def self.category?(stream_name)
        !stream_name.include?('-')
      end
    end
  end
end
