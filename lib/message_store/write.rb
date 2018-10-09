module MessageStore
  module Write
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        extend Build
        extend Call
        extend Configure

        dependency :identifier, Identifier::UUID::Random

        abstract :configure
        abstract :write
      end
    end

    module Build
      def build(session: nil)
        instance = new
        Identifier::UUID::Random.configure(instance)
        instance.configure(session: session)
        instance
      end
    end

    module Configure
      def configure(receiver, session: nil, attr_name: nil)
        attr_name ||= :write
        instance = build(session: session)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    module Call
      def call(message_data, stream_name, expected_version: nil, session: nil)
        instance = build(session: session)
        instance.(message_data, stream_name, expected_version: expected_version)
      end
    end

    def call(message_data, stream_name, expected_version: nil)
      batch = Array(message_data)

      logger.trace(tag: :write) do
        message_types = batch.map {|message_data| message_data.type }.uniq.join(', ')
        "Writing message data (Types: #{message_types}, Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect}, Number of Messages: #{batch.length})"
      end
      logger.trace(tags: [:data, :message_data]) { batch.pretty_inspect }

      set_ids(batch)

      position = write(batch, stream_name, expected_version: expected_version)

      logger.info(tag: :write) do
        message_types = batch.map {|message_data| message_data.type }.uniq.join(', ')
        "Wrote message data (Types: #{message_types}, Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect}, Number of Messages: #{batch.length})"
      end
      logger.info(tags: [:data, :message_data]) { batch.pretty_inspect }

      position
    end
    alias :write :call

    def set_ids(batch)
      batch.each do |message_data|
        if message_data.id.nil?
          message_data.id = identifier.get
        end
      end
    end
  end
end
