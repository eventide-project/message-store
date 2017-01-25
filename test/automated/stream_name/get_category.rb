require_relative '../automated_init'

context "Stream Name" do
  context "Category" do
    category = 'someStream'

    context "Stream Name Contains an ID" do
      id = Identifier::UUID.random
      stream_name = "#{category}-#{id}"

      stream_category = StreamName.get_category(stream_name)

      test "Category name is the part of the stream name before the first dash" do
        assert(stream_category == category)
      end
    end

    context "Stream Name Contains no ID" do
      stream_category = StreamName.get_category(category)

      test "Category name is the stream name" do
        assert(stream_category == category)
      end
    end
  end
end
