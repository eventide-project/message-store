require_relative '../automated_init'

context "Read" do
  context "No block supplied" do
    reader = Controls::Read.example

    test "Is incorrect" do
      assert_raises Read::Error do
        reader.()
      end
    end
  end
end
