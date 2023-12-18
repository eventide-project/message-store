require_relative '../automated_init'

context "Get Last" do
  context "Configure" do
    context "Session Given" do
      session = Object.new

      receiver = OpenStruct.new

      Get::Stream::Last.configure(receiver, session: session)

      get_last = receiver.get_last

      test "Session is set" do
        assert(get_last.session == session)
      end
    end

    context "Session Not Given" do
      receiver = OpenStruct.new

      Get::Stream::Last.configure(receiver)

      get_last = receiver.get_last

      test "Default session is used" do
        refute(get_last.session.nil?)
      end
    end

    context "Attribute Name Specified" do
      receiver = OpenStruct.new

      Get::Stream::Last.configure(receiver, attr_name: :some_attr)

      get_last = receiver.some_attr

      test do
        assert(get_last.is_a?(Get::Stream::Last))
      end
    end
  end
end
