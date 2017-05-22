module MessageStore
  class Log < ::Log
    def tag!(tags)
      tags << :message_store
      tags << :library
      tags << :verbose
    end
  end
end
