module EventSource
  module Controls
    module EventData
      def self.type
        'SomeType'
      end

      def self.data
        { :some_attribute => RandomValue.example }
      end
    end
  end
end
