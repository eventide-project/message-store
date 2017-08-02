require_relative '../automated_init'

context "Get Last" do
  context "Call" do
    stream_name = Controls::StreamName.example

    context "Not Specialized" do
      get_last = Controls::GetLast.example

      test "Raises virtual method error" do
        assert proc { get_last.(stream_name) } do
          raises_error?(Virtual::PureMethodError)
        end
      end
    end

    context "Specialized" do
      get_last = Controls::GetLast.example

      specialized_method_executed = false

      get_last.define_singleton_method(:call) do |_stream_name|
        specialized_method_executed = true if _stream_name == stream_name
      end

      get_last.(stream_name)

      test "Executes specialized method" do
        assert(specialized_method_executed)
      end
    end
  end
end
