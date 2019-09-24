require_relative '../../../automated_init'

context "Iterator" do
  context "Stream Depletion" do
    context "Depleted" do
      context "Resulting Batch Size is Less Than the Requested Batch Size" do
        get = Controls::Get.example(batch_size: 2)
        iterator = Controls::Iterator.example
        iterator.get = get

        iterator.batch = [1]

        stream_depleted = iterator.stream_depleted?

        test "Stream is depleted" do
          assert(stream_depleted)
        end
      end
    end
  end
end
