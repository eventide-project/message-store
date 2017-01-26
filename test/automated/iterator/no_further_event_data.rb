require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    context "No further event data" do
      count = 3
      get = Controls::Get.example(batch_size: 2, count: count)

      iterator = Iterator.build(get, 'some_stream-some_id')

      count.times { iterator.next }

      last = iterator.next

      test "Results in nil" do
        assert(last.nil?)
      end
    end
  end
end
