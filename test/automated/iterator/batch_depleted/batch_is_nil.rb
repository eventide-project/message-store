require_relative '../../automated_init'

context "Iterator" do
  context "Batch Depleted" do
    context "Batch in Nil" do
      iterator = Controls::Iterator.example(stream_name: 'some_stream')

      iterator.batch = nil

      depleted = iterator.batch_depleted?

      test "Batch is depleted" do
        assert(depleted)
      end
    end
  end
end
