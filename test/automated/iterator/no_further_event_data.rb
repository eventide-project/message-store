require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    context "No further event data" do
      Iterator.precedences.each do |precedence|
        context "#{precedence}" do
          count = 3
          get = Controls::Get.example(batch_size: 2, count: count, precedence: precedence)

          iterator = Iterator.build(get, 'some_stream')

          count.times { iterator.next }

          last = iterator.next

          test "Results in nil" do
            assert(last.nil?)
          end
        end
      end
    end
  end
end
