module MessageStore
  module Get
    module Stream
      module Last
        module Substitute
          def self.build
            GetLast.new
          end

          class GetLast
            include Get::Stream::Last

            def call(stream_name, type: nil)
              streams[stream_name]
            end

            def set(stream_name, message_data)
              streams[stream_name] = message_data
            end

            def streams
              @streams ||= {}
            end
          end
        end
      end
    end
  end
end
