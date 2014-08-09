module Rdb
  class Engine
    # Database Board Record.
    #
    attr_reader :board

    def initialize(board)
      @board = board
    end

    def issues
      board.issues
    end

    def name
      board.name
    end

    def as_json(*)
      {
        id: board.id,
        name: board.name,
        type: self.class.name.split('::').last.downcase
      }
    end

    def update(params)
      board.update_attributes! name: params[:name]
      board
    end

    class << self
      def lookup(name)
        if (engine = engines.detect { |klass| klass.name == name })
          engine
        else
          begin
            name.constantize
          rescue NameError
            nil
          end
        end
      end

      def lookup!(name)
        lookup(name).tap do |engine|
          raise NameError.new "No rdb board engine '#{name}' found.\nAvailable engines: #{engines.map(&:name).join(', ')}" unless engine
        end
      end

      def engines
        @engines ||= []
      end
    end
  end
end
