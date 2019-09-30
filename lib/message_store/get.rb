module MessageStore
  module Get
    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Initializer
        include Virtual
        include Log::Dependency

        abstract :call
        abstract :last_position
        abstract :stream_name
        abstract :batch_size
      end
    end
  end
end
