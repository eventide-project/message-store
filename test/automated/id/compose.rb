require_relative '../automated_init'

context "ID" do
  context "Compose" do
    context "Singular ID" do
      context "Not Nil" do
        id = 'some_id'

        composed_id = MessageStore::ID.id(id)

        test "Composed ID is the singular ID" do
          assert(composed_id == id)
        end
      end

      context "Nil" do
        id = nil

        test "Is an error" do
          assert_raises(MessageStore::ID::Error) do
            MessageStore::ID.id(id)
          end
        end
      end
    end

    context "List of IDs" do
      context "Not Empty" do
        id = ['some_id', 'some_other_id']

        composed_id = MessageStore::ID.id(id)

        test "Composed ID is the concatenation of the list of IDs delimited by the '+'' sign" do
          assert(composed_id == 'some_id+some_other_id')
        end
      end

      context "Empty" do
        id = []

        test "Is an error" do
          assert_raises(MessageStore::ID::Error) do
            MessageStore::ID.id(id)
          end
        end
      end
    end
  end
end
