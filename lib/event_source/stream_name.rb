module EventSource
  module StreamName
    extend self

    def stream_name(category_name, id=nil)
      id ||= Identifier::UUID.random

      "#{category_name}-#{id}"
    end

    def category_stream_name(category_name)
      category_name
    end

    def self.get_id(stream_name)
      id = stream_name.partition('-')[2]
      id.empty? ? nil : id
    end

    def self.category(stream_name)
      stream_name.split('-')[0]
    end
  end
end
