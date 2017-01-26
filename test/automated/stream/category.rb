require_relative '../automated_init'

context "Stream" do
  context "Category" do
    category = 'someStream'
    stream = Stream.new(category)

    test "Stream name is the category name" do
      assert(stream.name == category)
    end

    test "Category" do
      assert(stream.category == category)
    end

    test "No ID" do
      assert(stream.id.nil?)
    end

    test "No Type" do
      assert(stream.type.nil?)
    end

    test "Is a Category Stream" do
      assert(stream.category?)
    end
  end
end
