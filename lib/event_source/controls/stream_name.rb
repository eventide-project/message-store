module EventSource
  module Controls
    module StreamName
      def self.example(category: nil, id: nil, type: nil, randomize_category: nil)
        category ||= Category.example(category: category, randomize_category: randomize_category)
        id ||= Identifier::UUID.random

        unless type.nil?
          category = "#{category}:#{type}"
        end

        "#{category}-#{id}"
      end
    end
  end
end
