require_relative '../automated_init'

context "Stream Name" do
  context "Get IDs" do
    test "Is the part of a stream name after the first dash" do
      id = 'some_id+some_other_id'
      stream_name = "someCategory-#{id}"

      stream_ids = StreamName.get_ids(stream_name)

      assert(stream_ids == ['some_id', 'some_other_id'])
    end

    test "Is empty array if there is no ID part in the stream name" do
      stream_ids = StreamName.get_ids('someStream')
      assert(stream_ids == [])
    end
  end
end
