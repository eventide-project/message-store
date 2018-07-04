require_relative '../automated_init'

context "Stream Name" do
  context "Missing Category" do
    test "Is an error" do
      assert proc { StreamName.stream_name(nil) } do
        raises_error? MessageStore::StreamName::Error
      end
    end
  end
end
