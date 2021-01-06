require_relative '../automated_init'

context "Get Cardinal ID" do
  context "Singular ID" do
    id = 'some_id'

    cardinal_id = ID.get_cardinal_id(id)

    test "Cardinal ID is the ID" do
      assert(cardinal_id == 'some_id')
    end
  end

  context "Compound ID" do
    id = 'some_id+some_other_id'

    cardinal_id = ID.get_cardinal_id(id)

    test "ID is the first ID" do
      assert(cardinal_id == 'some_id')
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
