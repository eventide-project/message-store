module EventSource
  class EventData
    include Schema::DataStructure

    attribute :type
    attribute :data
    attribute :metadata
  end
end
