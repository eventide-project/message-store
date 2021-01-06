require_relative '../automated_init'

context "Parse" do
  context "Singular ID" do
    id = 'some_id'

    parsed_id = ID.parse(id)

    test "Parsed IDis a list containing the ID" do
      assert(parsed_id == ['some_id'])
    end
  end

  context "Compound ID" do
    id = 'some_id+some_other_id'

    parsed_id = ID.parse(id)

    test "Parsed IDis a list containing the individual IDs" do
      assert(parsed_id == ['some_id', 'some_other_id'])
    end
  end

  context "Nil" do
    id = nil

    test "Is an error" do
      assert_raises(MessageStore::ID::Error) do
        ID.get_cardinal_id(id)
      end
    end
  end
end
