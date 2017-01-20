module EventSource
  class Stream
    initializer :name

    def self.get_type(name)
      subtype = name.split(':').last.split('-').first

      if name.start_with?(subtype)
        return :stream
      else
        return subtype.to_sym
      end
    end

    def self.canonize(stream)
      return stream if stream.is_a? self

      new stream
    end

    def type
      @type ||= self.class.get_type(name)
    end

    def category
      @category ||= StreamName.get_category(name)
    end

    def category?
      @is_category ||= !name.include?('-')
    end

    def ==(stream)
      name == stream.name
    end
  end
end
