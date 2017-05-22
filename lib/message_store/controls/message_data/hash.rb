module MessageStore
  module Controls
    module MessageData
      module Hash
        def self.data
          {
            some_attribute: 'some value'
          }
        end

        def self.example
          MessageStore::MessageData::Hash[data]
        end

        module JSON
          def self.data(id=nil)
            data = Hash.data
            Casing::Camel.(data, symbol_to_string: true)
          end

          def self.text
            ::JSON.generate(data)
          end
        end
      end
    end
  end
end
