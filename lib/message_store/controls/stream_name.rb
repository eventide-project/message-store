module MessageStore
  module Controls
    module StreamName
      def self.example(category: nil, id: nil, type: nil, types: nil, randomize_category: nil)
        if id == :none
          id = nil
        else
          id ||= Identifier::UUID.random
        end

        category = Category.example(category: category, randomize_category: randomize_category)

        stream_name(category, id, type: type, types: types)
      end

      def self.stream_name(category, id=nil, type: nil, types: nil)
        types = Array(types)
        types.unshift(type) unless type.nil?

        type_list = nil
        type_list = types.join('+') unless types.empty?

        stream_name = category
        stream_name = "#{stream_name}:#{type_list}" unless type_list.nil?
        stream_name = "#{stream_name}-#{id}" unless id.nil?

        stream_name
      end
    end
  end
end



