require_relative '../../../automated_init'

context "Iterator" do
  context "Stream Depletion" do
    context "Not Depleted" do
      context "Batch is Uninitialized" do
        get = Controls::Get.example(batch_size: 2)

        iterator = Read::Iterator.build
        iterator.get = get

        iterator.batch = nil

        stream_depleted = iterator.stream_depleted?

        test "Stream is not depleted" do
          refute(stream_depleted)
        end
      end
    end
  end
end
