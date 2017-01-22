require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    Iterator.precedences.each do |precedence|
      context "#{precedence}" do
        get = Controls::Get.example(batch_size: 1, count: 2, precedence: precedence)

        iterator = Iterator.build(get, 'some_stream')

        batch = []

        2.times do
          event_data = iterator.next
          batch << event_data unless event_data.nil?
        end

        test "Gets each event" do
          assert(batch.length == 2)
        end
      end
    end
  end
end
