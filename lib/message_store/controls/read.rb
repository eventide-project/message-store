module MessageStore
  module Controls
    module Read
      def self.example(stream_name: nil)
        stream_name ||= StreamName.example

        read = Example.build(stream_name)

        get = Get.example(stream_name: stream_name)
        read.iterator.get = get

        read
      end

      class Example
        include MessageStore::Read

        def configure(*); end
      end
    end
  end
end
