require_relative '../automated_init'

context "Stream" do
  context "Category" do
    category = 'someStream'
    stream_name = category
    stream = Stream.new(stream_name)

    test "Type" do
      assert(stream.type.nil?)
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
