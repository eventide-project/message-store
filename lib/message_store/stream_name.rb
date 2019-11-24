module MessageStore
  module StreamName
    Error = Class.new(RuntimeError)

    def self.id_separator
      '-'
    end

    def self.compound_id_separator
      '+'
    end

    def self.category_separator
      ':'
    end

    def self.type_separator
      '+'
    end

    def self.stream_name(category_name, stream_id=nil, cardinal_id: nil, id: nil, ids: nil, type: nil, types: nil)
      if category_name == nil
        raise Error, "Category name must not be omitted from stream name"
      end

      types = Array(types)
      types.unshift(type) unless type.nil?

      type_list = nil
      type_list = types.join(type_separator) unless types.empty?

      stream_name = category_name
      stream_name = "#{stream_name}#{category_separator}#{type_list}" unless type_list.nil?

      id_list = []

      id_list << cardinal_id if not cardinal_id.nil?

      if not stream_id.nil?
        if stream_id.is_a?(Array)
          id_list.concat(stream_id)
        else
          id_list << stream_id
        end
      end

      if not id.nil?
        if id.is_a?(Array)
          id_list.concat(id)
        else
          id_list << id
        end
      end

      if not ids.nil?
        if ids.is_a?(Array)
          id_list.concat(ids)
        else
          id_list << ids
        end
      end

      composed_id = nil
      if not id_list.empty?
        composed_id = id_list.join(compound_id_separator)
        stream_name = "#{stream_name}#{id_separator}#{composed_id}"
      end

      stream_name
    end

    def self.split(stream_name)
      stream_name.split(id_separator, 2)
    end

    def self.get_id(stream_name)
      split(stream_name)[1]
    end

    def self.get_ids(stream_name)
      ids = get_id(stream_name)

      return [] if ids.nil?

      ids.split(compound_id_separator)
    end

    def self.get_cardinal_id(stream_name)
      id = get_id(stream_name)

      return nil if id.nil?

      id.split(compound_id_separator).first
    end

    def self.get_category(stream_name)
      split(stream_name)[0]
    end

    def self.category?(stream_name)
      !stream_name.include?(id_separator)
    end

    def self.get_category_type(stream_name)
      return nil unless stream_name.include?(category_separator)

      category = get_category(stream_name)

      category.split(category_separator)[1]
    end

    def self.get_type(*args)
      get_category_type(*args)
    end

    def self.get_category_types(stream_name)
      type_list = get_type(stream_name)

      return [] if type_list.nil?

      type_list.split(type_separator)
    end

    def self.get_types(*args)
      get_category_types(*args)
    end

    def self.get_entity_name(stream_name)
      get_category(stream_name).split(category_separator)[0]
    end
  end
end
