require_relative '../../../automated_init'

context "Iterator" do
  context "Batch Depletion" do
    context "Depleted" do
      context "Batch in Empty" do
        iterator = Read::Iterator.build

        iterator.batch = []

        batch_depleted = iterator.batch_depleted?

        test "Batch is depleted" do
          assert(batch_depleted)
        end
      end
    end
  end
end
