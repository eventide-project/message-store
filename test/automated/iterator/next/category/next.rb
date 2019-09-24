require_relative '../../../automated_init'

context "Iterator" do
  context "Next" do
    count = 3
    get = Controls::Get.example(batch_size: 2, count: count)

    iterator = Controls::Iterator.example(stream_name: 'some_stream')
    iterator.get = get

    batch = []

    count.times do
      message_data = iterator.next
      batch << message_data unless message_data.nil?
    end

    test "Gets each message" do
      assert(batch.length == count)
    end
  end
end
