require_relative '../../automated_init'

context "Iterator" do
  context "Next" do
    count = 3
    get = Controls::Get.example(batch_size: 2, count: count, global_position_offset: -> (x) { 2 + x ** 2 })

    iterator = Controls::Iterator.example(stream_name: 'some_stream', position: 3)
    iterator.get = get

    batch = []

    count.times do
      message_data = iterator.next
      batch << message_data unless message_data.nil?
    end

    test "Gets each event" do
      assert(batch.length == count - 1)
    end
  end
end
