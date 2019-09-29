require_relative '../../../automated_init'

context "Iterator" do
  context "Next" do
    count = 3

    category = Controls::Category.example
    get = Controls::Get.example(stream_name: category, batch_size: 2, count: count, global_position_offset: -> (x) { 2 + x ** 2 })

# get.stream_name = Controls::Category.example


## Iterator no longer takes stream name
##    iterator = Controls::Iterator.example(stream_name: 'some_stream', position: 3)
    iterator = Controls::Iterator.example(position: 3)
    iterator.get = get

    batch = []

    count.times do
      message_data = iterator.next

      break if message_data.nil?
      batch << message_data
    end

    test "Gets each message" do
      assert(batch.length == count - 1)
    end
  end
end
