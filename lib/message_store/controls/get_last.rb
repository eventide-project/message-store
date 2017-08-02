module MessageStore
  module Controls
    module GetLast
      def self.example
        Example.build
      end

      def self.default_session
        :default_session
      end

      class Example
        include MessageStore::Get::Last

        attr_writer :session
        def session
          @session ||= GetLast.default_session
        end

        def call(stream_name)
        end

        def configure(session: nil)
          self.session = session
        end

        def session?(session)
          self.session.equal?(session)
        end
      end
    end
  end
end
