module MessageStore
  module Controls
    module Read
      def self.example(stream_name: nil)
        stream_name ||= StreamName.example

        read = MessageStore::Read.build(stream_name)

        read
      end
    end
  end
end
