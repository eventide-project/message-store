require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Missing Category" do
      test "Is an error" do
        assert_raises(MessageStore::StreamName::Error) do
          StreamName.stream_name(nil)
        end
      end
    end
  end
end
