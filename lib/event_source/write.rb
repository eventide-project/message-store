module EventSource
  module Write
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        abstract :configure
      end
    end

    module Build
      def build(session: nil)
        instance = new
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
      logger.trace { "Writing event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.trace(tags: [:data, :event_data]) { event_data.pretty_inspect }

      batch = Array(event_data)

      position = write(batch, stream_name, expected_version: expected_version)

      logger.info { "Wrote event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.info(tags: [:data, :event_data]) { event_data.pretty_inspect }

      position
    end
  end
end
