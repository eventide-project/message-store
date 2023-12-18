require_relative '../../automated_init'

context "Put" do
  context "Message" do
    context "Expected Version" do
      stream_name = Controls::StreamName.example

      write_message_1 = Controls::MessageData::Write.example

      position = Put.(write_message_1, stream_name)

      write_message_2 = Controls::MessageData::Write.example

      Put.(write_message_2, stream_name, expected_version: position)

      read_message = Get.(stream_name, position: position + 1).first

      test "Got the message that was written" do
        assert(read_message.data == write_message_2.data)
      end
    end
  end
end
