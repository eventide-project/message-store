module EventSource
  module Write
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        dependency :put

        abstract :configure
      end
    end

    module Build
      def build(partition: nil, session: nil)
        instance = new
        instance.configure(partition: partition, session: session)
        instance
      end
    end

    module Configure
      def configure(receiver, partition: nil, session: nil, attr_name: nil)
        attr_name ||= :writer
        instance = build(partition: partition, session: session)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    module Call
      def call(event_data, stream_name, expected_version: nil, partition: nil, session: nil)
        instance = build(partition: partition, session: session)
        instance.(event_data, stream_name, expected_version: expected_version)
      end
    end

    def call(event_data, stream_name, expected_version: nil)
      logger.trace { "Writing event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.trace(tags: [:data, :event_data]) { event_data.pretty_inspect }

      batch = Array(event_data)
      position = write_batch(batch, stream_name, expected_version: expected_version)

      logger.info { "Wrote event data (Stream Name: #{stream_name}, Expected Version: #{expected_version.inspect})" }
      logger.info(tags: [:data, :event_data]) { event_data.pretty_inspect }

      position
    end

    def write_batch(batch, stream_name, expected_version: nil)
      logger.trace { "Writing batch (Stream Name: #{stream_name}, Number of Events: #{batch.length}, Expected Version: #{expected_version.inspect})" }

      # unless expected_version.nil?
      #   expected_version =
      # end

      last_position = nil
      put.session.transaction do
        batch.each do |event_data|
          last_position = write(event_data, stream_name, expected_version: expected_version)
        end
      end

      logger.debug { "Wrote batch (Stream Name: #{stream_name}, Number of Events: #{batch.length}, Expected Version: #{expected_version.inspect})" }

      last_position
    end

    def write(event_data, stream_name, expected_version: nil)
      logger.trace { "Writing event data (Stream Name: #{stream_name}, Type: #{event_data.type}, Expected Version: #{expected_version.inspect})" }
      logger.trace(tags: [:data, :event_data]) { event_data.pretty_inspect }

      put.(event_data, stream_name, expected_version: expected_version).tap do
        logger.debug { "Wrote event data (Stream Name: #{stream_name}, Type: #{event_data.type}, Expected Version: #{expected_version.inspect})" }
        logger.debug(tags: [:data, :event_data]) { event_data.pretty_inspect }
      end
    end
  end
end
