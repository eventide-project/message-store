module MessageStore
  module Get
    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Initializer
        include Virtual
        include Log::Dependency

        abstract :call
        abstract :stream_name
        abstract :batch_size
        abstract :last_position
      end
    end
  end
end
