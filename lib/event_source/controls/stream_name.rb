module EventSource
  module Controls
    module StreamName
      def self.example(category: nil, id: nil, type: nil, types: nil, randomize_category: nil)
        category ||= Category.example(category: category, randomize_category: randomize_category)
        id ||= Identifier::UUID.random

        EventSource::StreamName.stream_name(category, id, type: type)
      end
    end
  end
end
