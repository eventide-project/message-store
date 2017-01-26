require_relative '../automated_init'

context "Stream" do
  context "Category and Type" do
    stream_name = 'someStream:someType'
    stream = Stream.new(stream_name)

    test "ID" do
      assert(stream.id.nil?)
    end

    test "Type" do
      assert(stream.type == 'someType')
    end

    test "Is a Category Stream" do
      assert(stream.category?)
    end

    test "Name" do
      assert(stream.name == stream_name)
    end

    test "Category" do
      assert(stream.category == stream_name)
    end
  end
end
