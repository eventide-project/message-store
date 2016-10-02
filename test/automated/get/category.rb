require_relative '../automated_init'

context "Get" do
  context "Category" do
    category = Controls::Category.example

    Controls::Put.(instances: 2, category: category)

    events = Get.(category: category)

    test "Number of events retrieved is the number written to the category" do
      number_of_events = events.length
      assert(number_of_events == 2)
    end
  end
end
