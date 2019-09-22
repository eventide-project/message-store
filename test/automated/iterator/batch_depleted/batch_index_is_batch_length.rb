require_relative '../../automated_init'

context "Iterator" do
  context "Batch Depleted" do
    context "Batch Index is the Batch Length" do
      iterator = Controls::Iterator.example(stream_name: 'some_stream')

      iterator.batch = [1, 11]
      iterator.batch_index = 2

      depleted = iterator.batch_depleted?

      test "Batch is depleted" do
        assert(depleted)
      end
    end
  end
end
