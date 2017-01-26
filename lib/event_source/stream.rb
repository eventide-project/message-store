module EventSource
  class Stream
    initializer :name

    def self.build(subject)
      return subject if subject.is_a? self
      new(subject)
    end

    def id
      @id ||= StreamName.get_id(name)
    end

    def category
      @category ||= StreamName.get_category(name)
    end

    def type
      @type ||= StreamName.get_type(name)
    end

    def category?
      @is_category ||= StreamName.category?(name)
    end

    def ==(stream)
      name == stream.name
    end
  end
end
