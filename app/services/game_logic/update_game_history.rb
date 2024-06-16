module GameLogic
    class UpdateGameHistory
        def initialize(game)
            @game = game
        end

        def call
            history_creator = GptManager::CreateHistory.new(@game)
            new_history = history_creator.create_history
            @game.update(history: new_history)
        end
    end
end
