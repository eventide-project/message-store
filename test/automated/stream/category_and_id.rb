require_relative '../automated_init'

context "Stream" do
  context "Category and ID" do
    category = 'someStream'
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

    test "No type" do
      assert(stream.type.nil?)
    end

    test "Is not a Category Stream" do
      refute(stream.category?)
    end
  end
end
