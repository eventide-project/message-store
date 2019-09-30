require_relative '../../../automated_init'

context "Iterator" do
  context "Batch Depletion" do
    context "Not Depleted" do
      context "Batch Index is Less Than the Batch Length" do
        iterator = Read::Iterator.build

        iterator.batch = [1, 11]
        iterator.batch_index = 1

        batch_depleted = iterator.batch_depleted?

        test "Batch is not depleted" do
          refute(batch_depleted)
        end
      end
    end
  end
end
