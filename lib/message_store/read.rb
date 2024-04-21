module MessageStore
  module Read
    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Initializer
        include TemplateMethod
        include Log::Dependency

        extend Build
        extend Call
        extend Configure

        dependency :iterator, Iterator

        initializer :stream_name, :position, :batch_size

        template_method! :configure
      end
    end

    Error = Class.new(RuntimeError)

    module Build
      def build(stream_name, position: nil, batch_size: nil, session: nil, **arguments)
        new(stream_name, position, batch_size).tap do |instance|
          Iterator.configure(instance, position)
          instance.configure(session: session, **arguments)
        end
      end
    end

    module Call
      def call(stream_name, position: nil, batch_size: nil, session: nil, **arguments, &action)
        instance = build(stream_name, position: position, batch_size: batch_size, session: session, **arguments)
        instance.(&action)
      end
    end

    module Configure
      def configure(receiver, stream_name, attr_name: nil, position: nil, batch_size: nil, session: nil, **arguments)
        attr_name ||= :read
        instance = build(stream_name, position: position, batch_size: batch_size, session: session, **arguments)
        receiver.public_send "#{attr_name}=", instance
      end
    end

    def call(&action)
      logger.trace(tag: :read) { "Reading (Stream Name: #{stream_name})" }

      if action.nil?
        error_message = "Reader must be actuated with a block"
        logger.error(tag: :read) { error_message }
        raise Error, error_message
      end

      enumerate_message_data(&action)

      logger.info(tag: :read) { "Reading completed (Stream Name: #{stream_name})" }

      return AsyncInvocation::Incorrect
    end

    def enumerate_message_data(&action)
      logger.trace(tag: :read) { "Enumerating (Stream Name: #{stream_name})" }

      message_data = nil

      loop do
        message_data = iterator.next

        break if message_data.nil?
        logger.debug(tags: [:data, :message_data]) { message_data.pretty_inspect }

        action.(message_data)
      end

      logger.debug(tag: :read) { "Enumerated (Stream Name: #{stream_name})" }
    end
  end
end
