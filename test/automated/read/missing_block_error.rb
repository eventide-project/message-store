require_relative '../automated_init'

context "Read" do
  context "No block supplied" do
    read = Controls::Read.example

    test "Is incorrect" do
      assert proc { read.() } do
        raises_error? Read::Error
      end
    end
  end
end
