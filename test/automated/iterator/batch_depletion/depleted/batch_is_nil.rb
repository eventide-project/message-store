require_relative '../../../automated_init'

context "Iterator" do
  context "Batch Depletion" do
    context "Depleted" do
      context "Batch in Nil" do
        iterator = Read::Iterator.build

        iterator.batch = nil

        batch_depleted = iterator.batch_depleted?

        test "Batch is depleted" do
          assert(batch_depleted)
        end
      end
    end
  end
end
