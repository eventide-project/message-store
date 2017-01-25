require_relative '../automated_init'

context "Stream" do
  context "Category, ID, and Type" do
    category = 'someStream:someType'
    stream_name = Controls::StreamName.example(id: 'some_id', category: category)
    stream = Stream.new(stream_name)

    test "Name" do
      assert(stream.name == stream_name)
    end

    test "Category" do
      assert(stream.category == category)
    end

    test "ID" do
      assert(stream.id == 'some_id')
    end

    test "Type" do
      assert(stream.type == 'someType')
    end

    test "Is not a Category Stream" do
      refute(stream.category?)
    end
  end
end
