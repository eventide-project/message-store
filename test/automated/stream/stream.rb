require_relative '../automated_init'

context "Stream" do
  context "Stream" do
    category = 'someStream'
    stream_name = Controls::StreamName.example(id: 'some_id', category: category)
    stream = Stream.new(stream_name)

    test "ID" do
      assert(stream.id == 'some_id')
    end

    test "Type" do
      assert(stream.type.nil?)
    end

    test "Is a Category Stream" do
      refute(stream.category?)
    end

    test "Name" do
      assert(stream.name == stream_name)
    end

    test "Category" do
      assert(stream.category == category)
    end
  end
end
