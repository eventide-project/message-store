require_relative '../automated_init'

context "Get ID" do
  test "Is the second part of a category following a colon separator" do
    stream_name = "someStream:someType"

    type = StreamName.get_type(stream_name)

    assert(type == 'someType')
  end

  test "Is nil if there is no type part in the stream name" do
    type = StreamName.get_type('someStream')
    assert(type.nil?)
  end
end
