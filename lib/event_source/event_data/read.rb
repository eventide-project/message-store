module EventSource
  module EventData
    class Read
      include EventData

      attribute :stream_name
      attribute :position
      attribute :global_position
      attribute :time

      def category
        StreamName.get_category(stream_name)
      end
    end
  end
end
