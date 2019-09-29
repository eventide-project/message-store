module MessageStore
  module Controls
    module Read
      def self.example(stream_name: nil)
        stream_name ||= StreamName.example

        iterator = Iterator.example
        get = Get.example(stream_name: stream_name)

        iterator.get = get

        read = Example.build(stream_name)

        read.iterator = iterator

        read
      end

      class Example
        include MessageStore::Read

        def configure(*); end
      end
    end
  end
end
