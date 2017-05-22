module MessageStore
  module Controls
    module StreamName
      def self.example(category: nil, id: nil, type: nil, types: nil, randomize_category: nil)
        category ||= Category.example(category: category, randomize_category: randomize_category)
        id ||= Identifier::UUID.random

        stream_name(category, id, type: type, types: types)
      end

      def self.stream_name(category_name, id=nil, type: nil, types: nil)
        types = Array(types)
        types.unshift(type) unless type.nil?

        type_list = nil
        type_list = types.join('+') unless types.empty?

        stream_name = category_name
        stream_name = "#{stream_name}:#{type_list}" unless type_list.nil?
        stream_name = "#{stream_name}-#{id}" unless id.nil?

        stream_name
      end
    end
  end
end



