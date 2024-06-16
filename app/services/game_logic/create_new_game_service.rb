module GameLogic
  class CreateNewGameService
    def initialize(game)
      @game = game
    end

    def call
      GptManager::CreatePatrons.create_patrons(@game)
      GameLogic::CreateRelationshipsService.new(@game).call
    end
  end
end

