require_relative '../../automated_init'

context "Stream Name" do
  context "Get Type List" do
    context "Many Types" do
      stream_name = "someStream:someType+someOtherType"

      type_list = StreamName.get_type(stream_name)

      test "Types are the list of elements following a colon separator" do
        assert(type_list == 'someType+someOtherType')
      end
    end

    context "ID and Many Types" do
      stream_name = "someStream:someType+someOtherType-someID"

      type_list = StreamName.get_type(stream_name)

      test "Types are the list of elements following a colon separator and preceding the ID" do
        assert(type_list == 'someType+someOtherType')
      end
    end

    context "Single Type" do
      stream_name = "someStream:someType"

      type_list = StreamName.get_type(stream_name)

      test "Types are the list of elements following a colon separator and preceding the ID" do
        assert(type_list == 'someType')
      end
    end

    context "No type list in the stream name" do
      stream_name = "someStream"

      type_list = StreamName.get_type(stream_name)

      test "No types" do
        assert(type_list.nil?)
      end
    end
  end
end
