module EventSource
  module EventData
    class Read
      include EventData

      attribute :stream_name, String
      attribute :position, Integer
      attribute :global_position, Integer
      attribute :time, Time
    end
  end
end
