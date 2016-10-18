require_relative '../automated_init'

context "Stream" do
  context "Category" do
    category = 'someStream'
    stream_name = Controls::Category.example category: category, randomize_category: false
    stream = Stream.new(stream_name)

    test "Type" do
      assert(stream.type == :stream)
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
