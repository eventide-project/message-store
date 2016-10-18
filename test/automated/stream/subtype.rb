require_relative '../automated_init'

context "Stream" do
  context "Subtype" do
    category = 'someStream:subtype'
    stream_name = Controls::StreamName.example category: category
    stream = Stream.build(stream_name)

    test "Type" do
      assert(stream.type == :subtype)
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
