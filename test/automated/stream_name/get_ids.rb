require_relative '../automated_init'

context "Stream Name" do
  context "Get IDs" do
    context "Compound ID" do
      id = 'some_id+some_other_id'
      stream_name = "someCategory-#{id}"

      stream_ids = StreamName.get_ids(stream_name)

      test "Array of compound IDs" do
        assert(stream_ids == ['some_id', 'some_other_id'])
      end
    end

    context "Single ID" do
      id = 'some_id'
      stream_name = "someCategory-#{id}"

      stream_ids = StreamName.get_ids(stream_name)

      test "Array with single ID" do
        assert(stream_ids == ['some_id'])
      end
    end

    context "No ID" do
      stream_ids = StreamName.get_ids('someStream')

      test "Empty array" do
        assert(stream_ids == [])
      end
    end
  end
end
