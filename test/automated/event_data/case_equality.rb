require_relative '../automated_init'

context "MessageData" do
  context "Case Equality" do
    read_data = Controls::MessageData::Read.example

    context "Type is equal" do
      equal = read_data === read_data.type

      context "MessageData matches" do
        assert(equal)
      end
    end

    context "Type is not equal" do
      equal = read_data === SecureRandom.hex

      context "MessageData does not match" do
        refute(equal)
      end
    end
  end
end
