require_relative '../automated_init'

context "Get Last" do
  context "Call" do
    stream_name = Controls::StreamName.example
    type = Controls::MessageData.type

    context "Not Specialized" do
      cls = Class.new do
        include MessageStore::Get::Stream::Last
      end

      test "Raises virtual method error" do
        assert_raises(Virtual::PureMethod::Error) do
          cls.(stream_name)
        end
      end
    end

    context "Specialized" do
      specialized_method_executed = false

      cls = Class.new do
        include MessageStore::Get::Stream::Last

        define_method(:call) do |_stream_name, type=nil|
          specialized_method_executed = true if _stream_name == stream_name
        end
      end

      cls.(stream_name, type)

      test "Executes specialized method" do
        assert(specialized_method_executed)
      end
    end
  end
end
