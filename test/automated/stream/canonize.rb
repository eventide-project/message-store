require_relative '../automated_init'

context "Stream" do
  context "Canonize" do
    context "Stream" do
      stream = Controls::Stream.example

      canonized_stream = EventSource::Stream.canonize stream

      test "Stream is returned" do
        assert canonized_stream == stream
      end
    end

    context "String" do
      stream_name = Controls::StreamName.example

      canonized_stream = EventSource::Stream.canonize stream_name

      test "Stream is build using string as name" do
        assert canonized_stream.name == stream_name
      end
    end
  end
end
