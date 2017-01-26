module EventSource
  module StreamName
    def self.stream_name(category_name, id=nil, type: nil)
      stream_name = category_name
      stream_name = "#{stream_name}:#{type}" unless type.nil?
      stream_name = "#{stream_name}-#{id}" unless id.nil?

      stream_name
    end

    def self.get_id(stream_name)
      id = stream_name.partition('-')[2]
      id.empty? ? nil : id
    end

    def self.get_category(stream_name)
      stream_name.split('-')[0]
    end

    def self.category?(stream_name)
      !stream_name.include?('-')
    end

    def self.get_type(name)
      type = name.split(':').last.split('-').first

      return nil if name.start_with?(type)

      type
    end
  end
end
