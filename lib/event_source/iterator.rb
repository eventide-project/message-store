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
      logger.trace { "Getting next event data (Batch Length: #{batch.nil? ? '<none>' : batch.length}, Batch Position: #{batch_position})" }

      resupply(batch)

      event_data = batch[batch_position]

      logger.debug { "Finished getting next event data (Batch Length: #{batch.nil? ? '<none>' : batch.length}, Batch Position: #{batch_position})" }
      logger.debug(tags: [:data, :event_data]) { "Event Data: #{event_data.pretty_inspect}" }

      advance_batch_position

      event_data
    end

    def advance_batch_position
      self.batch_position += 1
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
      else
        logger.debug { "Current batch not depleted (#{batch_log_text}, Batch Position: #{batch_position})" }
      end

      logger.debug { "Finished resupplying batch" }
    end

    def get_batch
      logger.trace "Getting batch"

      batch = nil
      cycle.() do
        batch = get.(stream_name, position: next_batch_starting_position)
      end

      logger.debug { "Finished getting batch (Count: #{batch.length})" }

      batch
    end

    def next_batch_starting_position
      return 0 if batch.nil?

      if batch_position == batch.length
        return last_position + 1
      end

      current_position + 1
    end

    def current_position
      batch[batch_position].position
    end

    def last_position
      batch.last.position
    end

    def reset(batch)
      logger.trace { "Resetting batch" }

      self.batch = batch
      self.batch_position = 0

      logger.debug { "Reset batch" }
      logger.debug(tags: [:data, :batch]) { "Batch: #{batch.pretty_inspect}" }
      logger.debug(tags: [:data, :batch]) { "Batch Position: #{batch_position.inspect}" }
    end

    def self.precedences
      [
        :asc,
        :desc
      ]
    end
  end
end
