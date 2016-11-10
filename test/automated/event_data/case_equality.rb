require_relative '../automated_init'

context "EventData" do
  context "Case Equality" do
    read_data = Controls::EventData::Read.example

    context "Type is equal" do
      equal = read_data === read_data.type

      context "EventData matches" do
        assert(equal)
      end
    end

    context "Type is not equal" do
      equal = read_data === SecureRandom.hex

      context "EventData does not match" do
        refute(equal)
      end
    end
  end
end
