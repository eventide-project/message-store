module EventSource
  module StreamName
    def self.stream_name(category_name, id)
      "#{category_name}-#{id}"
    end

    def self.get_id(stream_name)
      id = stream_name.partition('-')[2]
      id.empty? ? nil : id
    end

    def self.get_category(stream_name)
      stream_name.split('-')[0]
    end
  end
end
