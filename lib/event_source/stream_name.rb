module EventSource
  module StreamName
    def self.stream_name(category_name, id, type=nil)
      unless type.nil?
        category_name = "#{category_name}:#{type}"
      end

      "#{category_name}-#{id}"
    end

    def self.get_id(stream_name)
      id = stream_name.partition('-')[2]
      id.empty? ? nil : id
    end

    def self.get_category(stream_name)
      stream_name.split('-')[0]
    end

    def self.get_type(name)
      type = name.split(':').last.split('-').first

      if name.start_with?(type)
        return :stream
      else
        return type.to_sym
      end
    end
  end
end
