require_relative '../../../automated_init'

context "Iterator" do
  context "Source Depleted" do
    context "Resulting Batch Size is Equal to the Requested Batch Size" do
      get = Controls::Get.example(batch_size: 2)
      iterator = Controls::Iterator.example
      iterator.get = get

      iterator.batch = [1, 11]

      source_depleted = iterator.source_depleted?

      test "Source is depleted" do
        refute(source_depleted)
      end
    end
  end
end
