require_relative '../../../automated_init'

context "Iterator" do
  context "Source Depleted" do
    context "Batch is Nil" do
      get = Controls::Get.example(batch_size: 2)
      iterator = Controls::Iterator.example
      iterator.get = get

      iterator.batch = nil

      source_depleted = iterator.source_depleted?

      test "Source is depleted" do
        assert(source_depleted)
      end
    end
  end
end
