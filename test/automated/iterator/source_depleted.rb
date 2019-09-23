require_relative '../automated_init'

context "Iterator" do
  context "Source Depleted" do
    context "Resulting Batch Size is Less Than the Requested Batch Size" do

## even with source_depleted predicate, we need a way
## to make sure that it's used

## iterator gets batch_size from the get dependency
## must set get's batch size

## batch.size < batch_size

## batch = get.(stream_name, position: position)

### test for iterator's batch_size is get's batch_size

## get has batch_size
## iterator has batch

      # batch = [1, 11]

      # get = Controls::Get::SourceDepleted.example(batch_size: 2)
      # get = Controls::Get.example(batch_size: 2)

      iterator = Controls::Iterator.example
      iterator.get.batch_size = 2

      # iterator.batch = batch
      # iterator.batch_index = 2

      # source_depleted = iterator.source_depleted?

      # test "Source is depleted" do
      #   assert(source_depleted)
      # end
    end
  end
end

__END__

def source_depleted?
  batch.size < batch_size
end
