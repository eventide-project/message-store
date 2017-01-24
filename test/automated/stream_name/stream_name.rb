require_relative '../automated_init'

context "Stream Name" do
  context do
    stream_name = StreamName.stream_name('someCategory', 'some_id')

    test "Composes the stream name from the category name and an ID" do
      assert(stream_name == 'someCategory-some_id')
    end
  end

  context do
    stream_name = StreamName.stream_name('someCategory', 'some_id', 'someType')

    test "Optionally includes a type" do
      assert(stream_name == 'someCategory:someType-some_id')
    end
  end
end
