require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Cardinal ID" do
      context "Cardinal ID" do
        stream_name = StreamName.stream_name('someCategory', cardinal_id: 'some_cardinal_id')

        test "Stream name is the category and the cardinal ID" do
          assert(stream_name == 'someCategory-some_cardinal_id')
        end
      end

      context "Cardinal ID and Positional ID" do
        stream_name = StreamName.stream_name('someCategory', 'some_positional_id', cardinal_id: 'some_cardinal_id')

        test "Stream name is the category, the cardinal ID, and the positional ID" do
          assert(stream_name == 'someCategory-some_cardinal_id+some_positional_id')
        end
      end

      context "Cardinal ID and Named ID Argument" do
        stream_name = StreamName.stream_name('someCategory', cardinal_id: 'some_cardinal_id', id: 'some_named_id')

        test "Stream name is the category, the cardinal ID, and the named ID" do
          assert(stream_name == 'someCategory-some_cardinal_id+some_named_id')
        end
      end

      context "Cardinal ID and Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', cardinal_id: 'some_cardinal_id', ids: 'some_named_ids')

        test "Stream name is the category, the cardinal ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_cardinal_id+some_named_ids')
        end
      end

      context "Cardinal ID, Named ID, and Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', cardinal_id: 'some_cardinal_id', id: 'some_named_id', ids: 'some_named_ids')

        test "Stream name is the category, the cardinal ID, the named ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_cardinal_id+some_named_id+some_named_ids')
        end
      end

      context "Cardinal ID, Positional ID, Named ID, and Named IDs Argument" do
        stream_name = StreamName.stream_name('someCategory', 'some_positional_id', cardinal_id: 'some_cardinal_id', id: 'some_named_id', ids: 'some_named_ids')

        test "Stream name is the category, the cardinal ID, the positional ID, the named ID, and the named IDs" do
          assert(stream_name == 'someCategory-some_cardinal_id+some_positional_id+some_named_id+some_named_ids')
        end
      end
    end
  end
end
