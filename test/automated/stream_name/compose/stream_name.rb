require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Stream Name" do
      context "Category, Type, Types, Positional ID, Cardinal ID, Named ID, and Named IDs" do
        stream_name = StreamName.stream_name('someCategory', 'some_id', cardinal_id: 'some_cardinal_id', id: 'some_named_id', ids: ['some_other_named_id', 'yet_another_named_id'], type: 'someType', types: ['someOtherType', 'yetAnotherType'])

        test "Stream name is the category, type, types, cardinal ID, positional ID, named ID, and named IDs" do
          assert(stream_name == 'someCategory:someType+someOtherType+yetAnotherType-some_cardinal_id+some_id+some_named_id+some_other_named_id+yet_another_named_id')
        end
      end
    end
  end
end
