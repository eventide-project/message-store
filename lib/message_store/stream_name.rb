module MessageStore
  module StreamName
    Error = Class.new(RuntimeError)

    def self.id_delimiter
      '-'
    end

    def self.category_delimiter
      ':'
    end

    def self.type_delimiter
      '+'
    end

    class << self
      alias :compound_id_delimiter :type_delimiter
    end

    def self.stream_name(category_name, id=nil, type: nil, types: nil)
      if category_name == nil
        raise Error, "Category name must not be omitted from stream name"
      end

      types = Array(types)
      types.unshift(type) unless type.nil?

      type_list = nil
      type_list = types.join(type_delimiter) unless types.empty?

      stream_name = category_name
      stream_name = "#{stream_name}#{category_delimiter}#{type_list}" unless type_list.nil?

      if not id.nil?
        if id.is_a?(Array)
          id = id.join(compound_id_delimiter)
        end
      end

      stream_name = "#{stream_name}#{id_delimiter}#{id}" unless id.nil?

      stream_name
    end

    def self.split(stream_name)
      stream_name.split(id_delimiter, 2)
    end

    def self.get_id(stream_name)
      split(stream_name)[1]
    end

    def self.get_ids(stream_name)
      ids = get_id(stream_name)

      return [] if ids.nil?

      ids.split(compound_id_delimiter)
    end

    def self.get_category(stream_name)
      split(stream_name)[0]
    end

    def self.category?(stream_name)
      !stream_name.include?(id_delimiter)
    end

    def self.get_type(stream_name)
      return nil unless stream_name.include?(category_delimiter)

      category = get_category(stream_name)

      category.split(category_delimiter)[1]
    end

    class << self
      alias :get_type_list :get_type
    end

    def self.get_types(stream_name)
      type_list = get_type_list(stream_name)

      return [] if type_list.nil?

      type_list.split(type_delimiter)
    end

    def self.get_entity_name(stream_name)
      get_category(stream_name).split(category_delimiter)[0]
    end
  end
end
