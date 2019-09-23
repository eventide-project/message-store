require_relative '../../../automated_init'

context "Iterator" do
  context "Stream Depleted" do
    context "Batch is Nil" do
      get = Controls::Get.example(batch_size: 2)
      iterator = Controls::Iterator.example
      iterator.get = get

      iterator.batch = nil

      stream_depleted = iterator.stream_depleted?

      test "Stream is depleted" do
        assert(stream_depleted)
      end
    end
  end
end
