require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Types" do
      context "Singular Types" do
        context "Category and Type" do
          stream_name = StreamName.stream_name('someCategory', type: 'someType')

          test "Stream name is the category and the Type" do
            assert(stream_name == 'someCategory:someType')
          end
        end

        context "Category and Types" do
          stream_name = StreamName.stream_name('someCategory', types: 'someTypes')

          test "Stream name is the category and the types" do
            assert(stream_name == 'someCategory:someTypes')
          end
        end

        context "Category, Type, and Types" do
          stream_name = StreamName.stream_name('someCategory', type: 'someType', types: 'someTypes')

          test "Stream name is the category and the types" do
            assert(stream_name == 'someCategory:someType+someTypes')
          end
        end
      end

      context "Plural Types" do
        context "Category and Type" do
          stream_name = StreamName.stream_name('someCategory', type: ['someType', 'someOtherType'])

          test "Stream name is the category and the type" do
            assert(stream_name == 'someCategory:someType+someOtherType')
          end
        end

        context "Category and Types" do
          stream_name = StreamName.stream_name('someCategory', types: ['someType', 'someOtherType'])

          test "Stream name is the category and the types" do
            assert(stream_name == 'someCategory:someType+someOtherType')
          end
        end

        context "Category, Type, and Types" do
          stream_name = StreamName.stream_name('someCategory', type: ['someType', 'someOtherType'], types: ['yetAnotherType', 'andAnotherType'])

          test "Stream name is the category and the types delimited by the plus (+) sign" do
            assert(stream_name == 'someCategory:someType+someOtherType+yetAnotherType+andAnotherType')
          end
        end
      end
    end
  end
end
