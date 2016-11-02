module EventSource
  class Log < ::Log
    def tag!(tags)
      tags << :event_source
      tags << :library
      tags << :verbose
    end
  end
end
