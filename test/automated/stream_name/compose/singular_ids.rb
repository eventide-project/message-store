require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Singular IDs" do
      context "Positional ID" do
        stream_name = StreamName.stream_name('someCategory', 'some_positional_id')

        test "Stream name is the category and the positional ID" do
          assert(stream_name == 'someCategory-some_positional_id')
        end
      end

      context "Named ID Argument" do
        stream_name = StreamName.stream_name('someCategory', id: 'some_named_id')

        test "Stream name is the category and the named ID" do
          assert(stream_name == 'someCategory-some_named_id')
        end
      end

      context "Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', ids: 'some_named_ids')

        test "Stream name is the category and the named IDs" do
          assert(stream_name == 'someCategory-some_named_ids')
        end
      end

      context "Named ID and Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', id: 'some_named_id', ids: 'some_named_ids')

        test "Stream name is the category, the cardinal ID, and the named ID" do
          assert(stream_name == 'someCategory-some_named_id+some_named_ids')
        end
      end

      context "Positional ID, Named ID, and Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', 'some_positional_id', id: 'some_named_id', ids: 'some_named_ids')

        test "Stream name is the category, the positional ID, the named ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_positional_id+some_named_id+some_named_ids')
        end
      end
    end
  end
end
