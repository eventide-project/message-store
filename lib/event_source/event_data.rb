module EventSource
  module EventData
    def self.included(cls)
      cls.class_exec do
        include Schema::DataStructure

        attribute :type
        attribute :data
        attribute :metadata

        def ===(other)
          type == other
        end
      end
    end
  end
end
