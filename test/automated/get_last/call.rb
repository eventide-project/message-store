require_relative '../automated_init'

context "Get Last" do
  context "Call" do
    stream_name = Controls::StreamName.example

    context "Not Specialized" do
      cls = Class.new do
        include MessageStore::Get::Last
      end

      test "Raises virtual method error" do
        assert proc { cls.(stream_name) } do
          raises_error?(Virtual::PureMethod::Error)
        end
      end
    end

    context "Specialized" do
      specialized_method_executed = false

      cls = Class.new do
        include MessageStore::Get::Last

        define_method(:call) do |_stream_name|
          specialized_method_executed = true if _stream_name == stream_name
        end
      end

      cls.(stream_name)

      test "Executes specialized method" do
        assert(specialized_method_executed)
      end
    end
  end
end
