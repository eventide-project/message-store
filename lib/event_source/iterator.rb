module EventSource
  class Iterator
    include Log::Dependency

    dependency :cycle, Cycle

    attr_accessor :starting_position
    attr_accessor :batch

    def batch_position
      @batch_position ||= 0
    end
    attr_writer :batch_position

    def precedence
      get.precedence
    end

    initializer :get, :stream_name

    def self.build(get, stream_name, position: nil, cycle: nil)
      new(get, stream_name).tap do |instance|
        instance.starting_position = position
        Cycle.configure instance, cycle: cycle
      end
    end

    def self.configure(receiver, get, stream_name, attr_name: nil, position: nil, cycle: nil)
      attr_name ||= :iterator
      instance = build(get, stream_name, position: position, cycle: cycle)
      receiver.public_send "#{attr_name}=", instance
    end

    def next
      logger.trace { "Getting next event data (Batch Length: #{batch.nil? ? '<none>' : batch.length}, Batch Position: #{batch_position}, Starting Position: #{starting_position.inspect})" }

      resupply(batch)

      event_data = batch[batch_position]

      logger.debug(tags: [:data, :event_data]) { "Next event data: #{event_data.pretty_inspect}" }
      logger.debug { "Done getting next event data (Batch Length: #{batch.nil? ? '<none>' : batch.length}, Batch Position: #{batch_position}, Starting Position: #{starting_position.inspect})" }

      advance_batch_position

      event_data
    end

    def advance_batch_position
      logger.trace { "Advancing batch position (Batch Position: #{batch_position})" }
      self.batch_position += 1
      logger.debug { "Advanced batch position (Batch Position: #{batch_position})" }
    end

    def resupply(batch)
      logger.trace { "Resupplying batch" }

      if batch.nil?
        batch_log_text = "Batch: #{batch.inspect}"
      else
        batch_log_text = "Batch Length: #{batch.length}"
      end

      if batch.nil? || batch_position == batch.length
        logger.debug { "Current batch is depleted (#{batch_log_text}, Batch Position: #{batch_position})" }

        batch = get_batch

        reset(batch)

        logger.debug { "Batch resupplied" }
      else
        logger.debug { "Batch not resupplied. Current batch not depleted (#{batch_log_text}, Batch Position: #{batch_position})" }
      end
    end

    def get_batch
      position = next_batch_starting_position

      logger.trace "Getting batch (Position: #{position.inspect})"

      if position.nil? || position >= 0
        batch = nil
        cycle.() do
          batch = get.(stream_name, position: position)
        end
      else
        batch = []
      end

      logger.debug { "Finished getting batch (Count: #{batch.length}, Position: #{position.inspect})" }

      batch
    end

    def next_batch_starting_position
      if batch.nil?
        logger.debug { "Batch is nil (Next batch starting position: nil)" }
        return nil
      end

      previous_position = last_position
      next_position = previous_position + (1 * (precedence == :asc ? 1 : -1))
      logger.debug { "End of batch (Next starting position: #{next_position}, Previous Position: #{previous_position})" }

      next_position
    end

    def last_position
      batch.last.position
    end

    def reset(batch)
      logger.trace { "Resetting batch" }

      self.batch = batch
      self.batch_position = 0

      logger.debug(tags: [:data, :batch]) { "Batch set to: \n#{batch.pretty_inspect}" }
      logger.debug(tags: [:data, :batch]) { "Batch position set to: #{batch_position.inspect}" }
      logger.debug { "Done resetting batch" }
    end

    def self.precedences
      [
        :asc,
        :desc
      ]
    end
  end
end
