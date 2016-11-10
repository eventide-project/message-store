require_relative '../automated_init'

context "EventData" do
  context "Hash" do
    context "JSON serialize" do
      example_hash = Controls::EventData::Hash.example
      control_serialized_text = Controls::EventData::Hash::JSON.text

      serialized_text = Transform::Write.(example_hash, :json)

      assert(serialized_text == control_serialized_text)
    end

    context "JSON deserialize" do
      example_serialized_text = Controls::EventData::Hash::JSON.text
      control_deserialized_hash = Controls::EventData::Hash.example

      deserialized_hash = Transform::Read.(example_serialized_text, EventData::Hash, :json)

      assert(deserialized_hash == control_deserialized_hash)
    end
  end
end
