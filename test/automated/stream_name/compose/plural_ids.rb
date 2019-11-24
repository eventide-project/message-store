require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Plural ID" do
      context "Positional ID Argument" do
        stream_name = StreamName.stream_name('someCategory', ['some_positional_id', 'some_other_positional_id'])

        test "Stream name is the category and the ID" do
          assert(stream_name == 'someCategory-some_positional_id+some_other_positional_id')
        end
      end

      context "Plural Named ID Argument" do
        stream_name = StreamName.stream_name('someCategory', id: ['some_named_id', 'some_other_named_id'])

        test "Stream name is the category, and the named ID" do
          assert(stream_name == 'someCategory-some_named_id+some_other_named_id')
        end
      end

      context "Plural Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', ids: ['some_named_id', 'some_other_named_id'])

        test "Stream name is the category, and the named IDs" do
          assert(stream_name == 'someCategory-some_named_id+some_other_named_id')
        end
      end

      context "Plural Named ID Argument, and Plural Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', id: ['some_named_id', 'some_other_named_id'], ids: ['yet_another_named_id', 'and_another_named_id'])

        test "Stream name is the category, the named ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_named_id+some_other_named_id+yet_another_named_id+and_another_named_id')
        end
      end

      context "Positional ID Argument, Plural Named ID Argument, and Plural Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', ['some_positional_id', 'some_other_positional_id'], id: ['some_named_id', 'some_other_named_id'], ids: ['yet_another_named_id', 'and_another_named_id'])

        test "Stream name is the category, the positional ID, and the named ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_positional_id+some_other_positional_id+some_named_id+some_other_named_id+yet_another_named_id+and_another_named_id')
        end
      end
    end
  end
end
