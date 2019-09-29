module MessageStore
  module Get
    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Initializer
        include Virtual
        include Log::Dependency

        abstract :call
      end
    end
  end
end
