module MessageStore
  module Controls
    module Iterator
      def self.example(position: nil)
        Example.build(position)
      end

      class Example
        include MessageStore::Read::Iterator

## This should be abstract and should defer to Get
        # def last_position
        #   ## stream name is only on Get now
        #   stream_name = get.stream_name

        #   unless self.class.category?(stream_name)
        #     batch.last.position
        #   else
        #     batch.last.global_position
        #   end
        # end

        # def self.category?(stream_name)
        #   !stream_name.include?('-')
        # end
      end
    end
  end
end
