require_relative '../automated_init'

context "Stream" do
  context "Canonize" do
    context "Stream" do
      stream = Controls::Stream.example

      built_stream = EventSource::Stream.build(stream)

      test "Stream is returned" do
        assert built_stream == stream
      end
    end

    context "String" do
      stream_name = Controls::StreamName.example

      built_stream = EventSource::Stream.build(stream_name)

      test "Stream is build using string as name" do
        assert built_stream.name == stream_name
      end
    end
  end
end
