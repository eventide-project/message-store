module MessageStore
  module Controls
    module Write
      def self.example
        Example.build
      end

      class Example
        include MessageStore::Write

        def configure(*)
        end

        def write(batch, stream_name, expected_version: nil)
          logger.trace { "Writing batch (Stream Name: #{stream_name}, Number of Events: #{batch.length}, Expected Version: #{expected_version.inspect})" }
          logger.debug { "Wrote batch (Stream Name: #{stream_name}, Number of Events: #{batch.length}, Expected Version: #{expected_version.inspect})" }

          nil
        end
      end
    end
  end
end
