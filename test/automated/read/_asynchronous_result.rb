require_relative '../automated_init'

context "Read" do
  context "Asynchronous Result" do
    reader = Controls::Read.example

    res = reader.() { }

    test "Returns a result that fails if actuated" do
      assert(res == AsyncInvocation::Incorrect)
    end
  end
end
