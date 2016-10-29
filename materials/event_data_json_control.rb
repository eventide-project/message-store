
        module JSON
          def self.data
            data = Read.data
            Casing::Camel.(data, symbol_to_string: true)
          end

          def self.text
            data.to_json
          end
        end
