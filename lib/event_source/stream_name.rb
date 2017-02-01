module EventSource
  module StreamName
    def self.stream_name(category_name, id=nil, type: nil, types: nil)
      types = Array(types)
      types.unshift(type) unless type.nil?

      type_list = nil
      type_list = types.join('+') unless types.empty?

      stream_name = category_name
      stream_name = "#{stream_name}:#{type_list}" unless type_list.nil?
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

    def self.get_type_list(name)
      type = name.split(':').last.split('-').first

      return nil if name.start_with?(type)

      type
    end

    def self.get_types(name)
      type_list = get_type_list(name)

      return nil if type_list.nil?

      type_list.split('+')
    end
  end
end
