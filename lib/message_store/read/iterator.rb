module MessageStore
  module Read
    module Iterator
      def self.included(cls)
        cls.class_exec do
          include Dependency
          include Initializer
          include Virtual
          include Log::Dependency

          extend Build
          extend Configure

          dependency :get, Get

          initializer :stream_name

          abstract :last_position
        end
      end

      attr_accessor :starting_position
      attr_accessor :batch

      def batch_index
        @batch_index ||= 0
      end
      attr_writer :batch_index

      def batch_size
        get.batch_size
      end

      module Build
        def build(stream_name, position: nil)
          new(stream_name).tap do |instance|
            instance.starting_position = position
            Log.get(self).debug { "Built Iterator (Stream Name: #{stream_name}, Starting Position: #{position.inspect})" }
          end
        end
      end

      module Configure
        def configure(receiver, stream_name, attr_name: nil, position: nil)
          attr_name ||= :iterator
          instance = build(stream_name, position: position)
          receiver.public_send "#{attr_name}=", instance
        end
      end

      def ___next
        logger.trace { "Getting next message data (Batch Length: #{(batch &.length).inspect}, Batch Index: #{batch_index})" }

        message_data = nil

        ## (batch &.length || -1) < batch_size
        ## source_depleted: fewer messages than requested
        unless stream_depleted?
        ##
          if batch_depleted?
            resupply
          end

          message_data = batch[batch_index]
        end

        logger.debug(tags: [:data, :message_data]) { "Next message data: #{message_data.pretty_inspect}" }
        logger.debug { "Done getting next message data (Batch Length: #{(batch &.length).inspect}, Batch Index: #{batch_index})" }

        advance_batch_index

        message_data
      end

      def next
        logger.trace { "Getting next message data (Batch Length: #{(batch &.length).inspect}, Batch Index: #{batch_index})" }

        if batch_depleted?
          resupply
        end

        message_data = batch[batch_index]

        logger.debug(tags: [:data, :message_data]) { "Next message data: #{message_data.pretty_inspect}" }
        logger.debug { "Done getting next message data (Batch Length: #{(batch &.length).inspect}, Batch Index: #{batch_index})" }

        advance_batch_index

        message_data
      end

      def resupply
        logger.trace { "Resupplying batch (Current Batch Length: #{(batch &.length).inspect})" }

##
        batch = []
        unless stream_depleted?
          batch = get_batch
        end
##

        reset(batch)

        logger.debug { "Batch resupplied (Next Batch Length: #{(batch &.length).inspect})" }
      end

      def get_batch
        position = next_batch_starting_position

        logger.trace "Getting batch (Position: #{position.inspect})"

        batch = []
        if position.nil? || position >= 0  ## Is this always true??
          batch = get.(stream_name, position: position)
        end

        logger.debug { "Finished getting batch (Count: #{batch.length}, Position: #{position.inspect})" }

        batch
      end

      def next_batch_starting_position
        if batch.nil?
          logger.debug { "Batch is nil (Next batch starting position: #{starting_position.inspect})" }
          return starting_position
        end

        previous_position = last_position
        next_position = previous_position + 1
        logger.debug { "End of batch (Next starting position: #{next_position}, Previous Position: #{previous_position})" }

        next_position
      end

      def reset(batch)
        logger.trace { "Resetting batch" }

        self.batch = batch
        self.batch_index = 0

        logger.debug(tags: [:data, :batch]) { "Batch set to: \n#{batch.pretty_inspect}" }
        logger.debug(tags: [:data, :batch]) { "Batch position set to: #{batch_index.inspect}" }
        logger.debug { "Done resetting batch" }
      end

      def advance_batch_index
        logger.trace { "Advancing batch index (Batch Index: #{batch_index})" }
        self.batch_index += 1
        logger.debug { "Advanced batch index (Batch Index: #{batch_index})" }
      end

      def batch_depleted?
        if batch.nil?
          logger.debug { "Batch is depleted (Batch is nil)" }
          return true
        end

        if batch.empty?
          logger.debug { "Batch is depleted (Batch is empty)" }
          return true
        end

        if batch_index == batch.length
          logger.debug { "Batch is depleted (Batch Index: #{batch_index}, Batch Length: #{batch.length})" }
          return true
        end

        false
      end

##
      def batch_initialized?
        !batch.nil?
      end
##

      def stream_depleted?
        if !batch_initialized?
          logger.debug { "Stream is not depleted (Batch Length: (batch is nil), Batch Size: #{batch_size})" }
          return false
        end

        if batch.length < batch_size
pp "!!! Stream Depleted"
          logger.debug { "Stream is depleted (Batch Length: #{batch.length}, Batch Size: #{batch_size})" }
          return true
        end

        logger.debug { "Stream is not depleted (Batch Length: #{batch.length || '(none)'}, Batch Size: #{batch_size})" }
        false
      end

      class Substitute
        include Read::Iterator

        initializer :stream_name

        def self.build()
          new('some_stream_name')
        end
      end
    end
  end
end
