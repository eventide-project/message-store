module EventSource
  class Stream
    initializer :name

    def self.build(name)
      self.new(name)
    end

    def self.get_type(name)
      subtype = name.split(':').last.split('-').first

      if name.start_with?(subtype)
        return :stream
      else
        return subtype.to_sym
      end
    end

    def type
      @type ||= self.class.get_type(name)
    end

    def category
      @category ||= StreamName.category(name)
    end

    def category?
      @is_category ||= !name.include?('-')
    end
  end
end
