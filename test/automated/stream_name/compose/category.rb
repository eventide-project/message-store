require_relative '../../automated_init'

context "Stream Name" do
  context "Compose" do
    context "Category" do
      stream_name = StreamName.stream_name('someCategory')

      test "Stream name is the category" do
        assert(stream_name == 'someCategory')
      end
    end
  end
end
