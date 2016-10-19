module EventSource
  module Controls
    module Stream
      def self.example(stream_name: nil, category: nil, id: nil, randomize_category: nil)
        stream_name ||= StreamName.example category: category, id: id, randomize_category: randomize_category
        ::Stream.new stream_name
      end

      module Category
        def self.example(category: nil, randomize_category: nil)
          category ||= Controls::Category.example category: category, randomize_category: randomize_category
          ::Stream.new category
        end
      end
    end
  end
end
