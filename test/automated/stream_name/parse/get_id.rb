require_relative '../../automated_init'

context "Stream Name" do
  context "Get ID" do
    context "Single ID in the Stream Name" do
      id = 'some_id'
      stream_name = "someCategory-#{id}"

      stream_id = StreamName.get_id(stream_name)

      test "ID value is parsed" do
        assert(stream_id == 'some_id')
      end
    end

    context "No ID in the Stream Name" do
      stream_id = StreamName.get_id('someStream')

      test "ID is nil" do
        assert(stream_id.nil?)
      end
    end
  end
end
