module EventSource
  module EventData
    class Read
      include EventData

      attribute :stream_name
      attribute :position
      attribute :global_position
      attribute :recorded_time

      def category
        StreamName.category(stream_name)
      end
    end
  end
end
