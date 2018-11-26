require_relative '../automated_init'

context "Stream Name" do
  context "Get Types" do
    context "Many Types" do
      test "Types are the list of elements following a colon separator" do
        stream_name = "someStream:someType+someOtherType"

        types = StreamName.get_types(stream_name)

        assert(types == ['someType', 'someOtherType'])
      end
    end

    context "ID and Many Types" do
      test "Types are the list of elements following a colon separator and preceding the ID" do
        stream_name = "someStream:someType+someOtherType-someID"

        types = StreamName.get_types(stream_name)

        assert(types == ['someType', 'someOtherType'])
      end
    end

    context "Single Type" do
      test "Types are the list of elements following a colon separator and preceding the ID" do
        stream_name = "someStream:someType"

        types = StreamName.get_types(stream_name)

        assert(types == ['someType'])
      end
    end

    context "No type list in the stream name" do
      types = StreamName.get_types('someStream')

      test "No types" do
        assert(types.empty?)
      end
    end
  end
end
