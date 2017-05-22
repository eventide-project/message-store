module MessageStore
  module MessageData
    def self.included(cls)
      cls.class_exec do
        include Schema::DataStructure

        attribute :id, String
        attribute :type, String
        attribute :data
        attribute :metadata

        def ===(other)
          type == other
        end
      end
    end
  end
end
