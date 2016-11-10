require_relative '../automated_init'

context "EventData" do
  context "Read" do
    context "Category" do
      read_data = EventData::Read.new
      read_data.stream_name = 'some_stream-some_id'

      category = read_data.category

      test "Is the first segment of the stream name" do
        assert(category == 'some_stream')
      end
    end
  end
end
