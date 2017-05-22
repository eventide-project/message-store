module MessageStore
  module Write
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

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
      def call(event_data, stream_name, expected_version: nil, session: nil)
        instance = build(session: session)
        instance.(event_data, stream_name, expected_version: expected_version)
      end
    end

    def call(event_data, stream_name, expected_version: nil)
      logger.trace(tag: :write) { "Writing event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.trace(tags: [:data, :event_data, :write]) { event_data.pretty_inspect }

      batch = Array(event_data)

      set_ids(batch)

      position = write(batch, stream_name, expected_version: expected_version)

      logger.info(tag: :write) { "Wrote event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.info(tags: [:data, :event_data, :write]) { event_data.pretty_inspect }

      position
    end

    def set_ids(batch)
      batch.each do |event_data|
        if event_data.id.nil?
          event_data.id = identifier.get
        end
      end
    end
  end
end
