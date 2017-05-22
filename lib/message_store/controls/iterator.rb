module MessageStore
  module Controls
    module Iterator
      def self.example(stream_name: nil, position: nil)
        stream_name ||= StreamName.example
        Example.build(stream_name, position: position)
      end

      class Example
        include MessageStore::Read::Iterator

        def last_position
          unless self.class.category?(stream_name)
            batch.last.position
          else
            batch.last.global_position
          end
        end

        def self.category?(stream_name)
          !stream_name.include?('-')
        end
      end
    end
  end
end
