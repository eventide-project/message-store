require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    count = 3
    get = Controls::Get.example(batch_size: 2, count: count)

    iterator = Iterator.build(get, 'some_stream', position: 1)

    batch = []

    count.times do
      event_data = iterator.next
      batch << event_data unless event_data.nil?
    end

    test "Gets each event" do
      assert(batch.length == count - 1)
    end
  end
end
