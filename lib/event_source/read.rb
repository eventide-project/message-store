module EventSource
  module Read
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency

        cls.extend Build
        cls.extend Call
        cls.extend Configure

        dependency :iterator, Iterator

        initializer :stream_name

        attr_accessor :get
        abstract :configure
      end
    end

    class Error < RuntimeError; end

    module Build
      def build(stream_name, position: nil, batch_size: nil, precedence: nil, partition: nil, delay_milliseconds: nil, timeout_milliseconds: nil, cycle: nil, session: nil)
        if cycle.nil?
          cycle = Cycle.build(delay_milliseconds: delay_milliseconds, timeout_milliseconds: timeout_milliseconds)
        end

        cycle ||= Cycle.build(delay_milliseconds: delay_milliseconds, timeout_milliseconds: timeout_milliseconds)

        new(stream_name).tap do |instance|
          instance.configure(stream_name, batch_size: batch_size, precedence: precedence, partition: partition, session: session)
          Iterator.configure instance, instance.get, position: position, cycle: cycle
        end
      end
    end

    module Call
      def call(stream_name, position: nil, batch_size: nil, precedence: nil, partition: nil, delay_milliseconds: nil, timeout_milliseconds: nil, cycle: nil, session: nil, &action)
        instance = build(stream_name, position: position, batch_size: batch_size, precedence: precedence, partition: partition, delay_milliseconds: delay_milliseconds, timeout_milliseconds: timeout_milliseconds, cycle: cycle, session: session)
        instance.(&action)
      end
    end

    module Configure
      def configure(receiver, stream_name, attr_name: nil, position: nil, batch_size: nil, precedence: nil, partition: nil, delay_milliseconds: nil, timeout_milliseconds: nil, cycle: nil, session: nil)
        attr_name ||= :reader
        instance = build(stream_name, position: position, batch_size: batch_size, precedence: precedence, partition: partition, delay_milliseconds: delay_milliseconds, timeout_milliseconds: timeout_milliseconds, cycle: cycle, session: session)
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

      enumerate_event_data(&action)

      logger.info { "Reading completed (Stream Name: #{stream_name})" }

      return AsyncInvocation::Incorrect
    end

    def enumerate_event_data(&action)
      logger.trace { "Reading (Stream Name: #{stream.name}, Category: #{stream.category?})" }

      event_data = nil

      loop do
        event_data = iterator.next

        break if event_data.nil?

        action.(event_data)
      end

      logger.debug { "Finished reading (Stream Name: #{stream.name}, Category: #{stream.category?})" }
    end
  end
end
