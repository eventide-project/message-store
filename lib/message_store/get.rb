module MessageStore
  module Get
    def self.included(cls)
      cls.class_exec do
        include Dependency
        include Initializer
        include TemplateMethod
        include Log::Dependency

        template_method! :call
        template_method! :stream_name
        template_method! :batch_size
        template_method! :last_position
      end
    end
  end
end
