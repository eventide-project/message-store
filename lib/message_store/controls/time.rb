module MessageStore
  module Controls
    module Time
      def self.example(time=nil)
        time ||= Raw.example
        ISO8601.example(time)
      end

      module Raw
        def self.example
          time = ::Time.parse("Jan 1 00:00:00 UTC 2000")
          Clock::UTC.now(time)
        end
      end

      module ISO8601
        def self.example(time=nil)
          time ||= Raw.example
          Clock::UTC.iso8601(time)
        end
      end

      module Processed
        def self.example(time=nil, offset_milliseconds: nil)
          time ||= Time::Raw.example
          time = Raw.example(time, offset_milliseconds: offset_milliseconds)
          ISO8601.example(time)
        end

        module Raw
          def self.example(time=nil, offset_milliseconds: nil)
            time ||= Time::Raw.example
            offset_milliseconds ||= 11
            offset = Rational(offset_milliseconds, 1000)
            time += offset
            time
          end
        end
      end

      module Effective
        def self.example(time=nil, offset_milliseconds: nil)
          time ||= Time::Raw.example
          time = Raw.example(time, offset_milliseconds: offset_milliseconds)
          ISO8601.example(time)
        end

        module Raw
          def self.example(time=nil, offset_milliseconds: nil)
            time ||= Time::Raw.example
            offset_milliseconds ||= 1
            offset = Rational(offset_milliseconds, 1000)
            time += offset
            time
          end
        end
      end
    end
  end
end
