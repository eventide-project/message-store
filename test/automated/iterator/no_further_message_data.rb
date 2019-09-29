require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    context "No further message data" do
      count = 3
      get = Controls::Get.example(batch_size: 2, count: count)

## No stream name passed to this control
##      iterator = Controls::Iterator.example(stream_name: 'some_stream-some_id')
      iterator = Controls::Iterator.example
      iterator.get = get

      count.times { iterator.next }

      last = iterator.next

      test "Results in nil" do
        assert(last.nil?)
      end
    end
  end
end
