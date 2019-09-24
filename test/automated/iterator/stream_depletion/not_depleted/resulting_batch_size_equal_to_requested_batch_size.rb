require_relative '../../../automated_init'

context "Iterator" do
  context "Stream Depleted" do
    context "Resulting Batch Size is Equal to the Requested Batch Size" do
      get = Controls::Get.example(batch_size: 2)
      iterator = Controls::Iterator.example
      iterator.get = get

      iterator.batch = [1, 11]

      stream_depleted = iterator.stream_depleted?

      test "Stream is depleted" do
        refute(stream_depleted)
      end
    end
  end
end
