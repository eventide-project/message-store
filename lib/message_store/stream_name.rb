module MessageStore
  module StreamName
    Error = Class.new(RuntimeError)

    def self.stream_name(category_name, id=nil, type: nil, types: nil)
      if category_name == nil
        raise Error, "Category name must not be omitted from stream name"
      end

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
      id = stream_name.partition('-').last
      id.empty? ? nil : id
    end

    def self.get_category(stream_name)
      stream_name.split('-').first
    end

    def self.category?(stream_name)
      !stream_name.include?('-')
    end

    def self.get_type_list(stream_name)
      return nil if stream_name.index(':').nil?

      category = get_category(stream_name)

      category.split(':').last
    end

    def self.get_types(stream_name)
      type_list = get_type_list(stream_name)

      return [] if type_list.nil?

      type_list.split('+')
    end

    def self.get_entity_name(stream_name)
      get_category(stream_name).split(':').first
    end
  end
end
