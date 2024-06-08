module GameLogic
  class CreateNewGameService
    def initialize(game)
      @game = game
    end

    def call
      GptManager::CreatePatrons.create_patrons(@game)
    end
  end
end

