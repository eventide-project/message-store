require_relative '../automated_init'

context "Iterator" do
  context "Next" do
    context "No further event data" do
      Iterator.precedences.each do |precedence|
        context "#{precedence}" do
          get = Controls::Get.example(batch_size: 1, count: 2, precedence: precedence)

          iterator = Iterator.build(get, 'some_stream')

          2.times { iterator.next }

          last = iterator.next

          test "Results in nil" do
            assert(last.nil?)
          end
        end
      end
    end
  end
end
