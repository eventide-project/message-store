require_relative '../automated_init'

context "Stream Name" do
  context "Get ID" do
    context "Single ID" do
      id = 'some_id'
      stream_name = "someCategory-#{id}"

      stream_id = StreamName.get_id(stream_name)

      test "Array with single ID" do
        assert(stream_id == 'some_id')
      end
    end

    context "No ID" do
      stream_id = StreamName.get_id('someStream')

      test "Nil" do
        assert(stream_id.nil?)
      end
    end
  end
end
