module MessageStore
  module Read
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        dependency :iterator, Iterator

        initializer :stream_name, :position, :batch_size

        abstract :configure
      end
    end

    class Error < RuntimeError; end

    module Build
      def build(stream_name, position: nil, batch_size: nil, session: nil)
        new(stream_name, position, batch_size).tap do |instance|
          instance.configure(session: session)
        end
      end
    end

    module Call
      def call(stream_name, position: nil, batch_size: nil, session: nil, &action)
        instance = build(stream_name, position: position, batch_size: batch_size, session: session)
        instance.(&action)
      end
    end

    module Configure
      def configure(receiver, stream_name, attr_name: nil, position: nil, batch_size: nil, session: nil)
        attr_name ||= :read
        instance = build(stream_name, position: position, batch_size: batch_size, session: session)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    def call(&action)
      logger.trace { "Reading (Stream Name: #{stream_name})" }

      if action.nil?
        error_message = "Reader must be actuated with a block"
        logger.error error_message
        raise Error, error_message
      end

      enumerate_message_data(&action)

      logger.info { "Reading completed (Stream Name: #{stream_name})" }

      return AsyncInvocation::Incorrect
    end

    def enumerate_message_data(&action)
      logger.trace { "Enumerating (Stream Name: #{stream_name})" }

      message_data = nil

      loop do
        message_data = iterator.next

        break if message_data.nil?

        action.(message_data)
      end

      logger.debug { "Enumerated (Stream Name: #{stream_name})" }
    end
  end
end
