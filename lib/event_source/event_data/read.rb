module EventSource
  module EventData
    class Read
      include EventData

      attribute :stream_name, String
      attribute :position, Integer
      attribute :global_position, Integer
      attribute :time, Time

      def category
        StreamName.get_category(stream_name)
      end
    end
  end
end
