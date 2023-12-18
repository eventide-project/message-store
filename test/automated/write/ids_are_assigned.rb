require_relative '../automated_init'

context "Write" do
  stream_name = Controls::StreamName.example

  write_message_1 = Controls::MessageData::Write.example(id: :none)
  write_message_2 = Controls::MessageData::Write.example
  write_message_3 = Controls::MessageData::Write.example(id: :none)

  id = write_message_2.id

  batch = [write_message_1, write_message_2, write_message_3]

  ## Review - Aaron, Sat Jan 21 2023
  write = Write.new
  write.put = Put.new
  write.(batch, stream_name)

  context "Missing IDs Are Assigned" do
    test "Message 1" do
      refute(write_message_1.id.nil?)
    end

    test "Message 3" do
      refute(write_message_3.id.nil?)
    end
  end

  context "Existing IDs Are not Assigned" do
    test "Message 2" do
      assert(write_message_2.id == id)
    end
  end
end
