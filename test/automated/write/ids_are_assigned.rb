require_relative '../automated_init'

context "Write" do
  stream_name = Controls::StreamName.example

  write_event_1 = Controls::MessageData::Write.example(id: :none)
  write_event_2 = Controls::MessageData::Write.example
  write_event_3 = Controls::MessageData::Write.example(id: :none)

  id = write_event_2.id

  batch = [write_event_1, write_event_2, write_event_3]

  Controls::Write::Example.(batch, stream_name)

  context "Missing IDs Are Assigned" do
    test "Event 1" do
      refute(write_event_1.id.nil?)
    end

    test "Event 3" do
      refute(write_event_3.id.nil?)
    end
  end

  context "Existing IDs Are not Assigned" do
    test "Event 2" do
      assert(write_event_2.id == id)
    end
  end
end
