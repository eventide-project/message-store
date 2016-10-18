require_relative '../automated_init'

context "Stream" do
  context "Subtype Category" do
    category = 'someStream:subtype'
    stream_name = Controls::Category.example category: category, randomize_category: false
    stream = Stream.build(stream_name)

    test "Type" do
      assert(stream.type == :subtype)
    end

    test "Is a Category Stream" do
      assert(stream.category?)
    end

    test "Name" do
      assert(stream.name == stream_name)
    end

    test "Category" do
      assert(stream.category == category)
    end
  end
end
