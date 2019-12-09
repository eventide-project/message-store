require_relative '../../automated_init'

context "Stream Name" do
  context "Get Cardinal ID" do
    context "Compound ID in the Stream Name" do
      id = 'some_id+some_other_id'
      stream_name = "someCategory-#{id}"

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "ID is a list of values" do
        assert(cardinal_id == 'some_id')
      end
    end

    context "Single ID in the Stream Name" do
      id = 'some_id'
      stream_name = "someCategory-#{id}"

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "ID list has a single entry" do
        assert(cardinal_id == 'some_id')
      end
    end

    context "No ID in the Stream Name" do
      stream_name = 'someStream'

      cardinal_id = StreamName.get_cardinal_id(stream_name)

      test "ID is an empty list" do
        assert(cardinal_id.nil?)
      end
    end
  end
end
