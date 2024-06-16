module GameLogic
  class CreateRelationshipsService
    def initialize(game)
      @game = game
    end

    def call
      patrons = @game.patrons.to_a
      patrons.combination(2).each do |patron_pair|
        patron1, patron2 = patron_pair.sort_by(&:id)
        PatronRelationship.create!(
          patron_id: patron1.id,
          other_patron_id: patron2.id,
          affinity: 0.5, # Default affinity value
          shared_history: "" # Default shared history
        )
      end
    end
  end
end
