require_relative '../automated_init'

context "Stream Name" do
  context "Category Predicate" do
    context "Stream Name Contains a Dash (-)" do
      stream_name = 'someStream-some_id'

      is_category = StreamName.category?(stream_name)

      test "Not a category" do
        refute(is_category)
      end
    end

    context "Stream Name Contains no Dash (-)" do
      stream_name = 'someStream'

      is_category = StreamName.category?(stream_name)

      test "Is a category" do
        assert(is_category)
      end
    end
  end
end
