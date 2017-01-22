require_relative '../../../automated_init'

context "Iterator" do
end

__END__

- offset must be replaced with where clauses relative to position (global_position for categories)
- so, need to get position from last event in batch
- last event is known to resupply function

    def advance_positions(batch)
      self.batch_position += 1
      self.current_position += 1
    end

current position will come from batch[current_position]
