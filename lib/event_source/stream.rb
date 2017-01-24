module EventSource
  class Stream
    initializer :name

    def self.canonize(stream)
      return stream if stream.is_a? self

      new stream
    end

    def type
      @type ||= StreamName.get_type(name)
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
