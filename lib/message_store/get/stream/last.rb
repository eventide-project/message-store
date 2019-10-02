module MessageStore
  module Get
    module Stream
      module Last
        def self.included(cls)
          cls.class_exec do
            include Dependency
            include Virtual
            include Log::Dependency

            extend Build
            extend Call
            extend Configure

            prepend InstanceActuator

            virtual :configure
            abstract :call

            const_set :Substitute, Substitute
          end
        end

        module InstanceActuator
          def call(stream_name)
            logger.trace(tag: :get) { "Getting last message data (Stream Name: #{stream_name})" }

            message_data = super

            logger.info(tag: :get) { "Finished getting message data (Stream Name: #{stream_name})" }
            logger.info(tags: [:data, :message_data]) { message_data.pretty_inspect }

            message_data
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
            attr_name ||= :get_last

            instance = build(session: session)
            receiver.public_send("#{attr_name}=", instance)
            instance
          end
        end

        module Call
          def call(stream_name, session: nil)
            instance = build(session: session)
            instance.(stream_name)
          end
        end
      end
    end
  end
end
