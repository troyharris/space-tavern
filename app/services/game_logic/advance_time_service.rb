module GameLogic
    class AdvanceTimeService
      def initialize(game)
        @game = game
      end
  
      def call
        puts "Advancing time for game #{@game.id}"
        # Handle patrons
        PatronManager::PatronService.new(@game).handle_patrons
        # Handle events
        EventManager::EventService.new(@game).handle_events
        # Update the game's time
        new_time = @game.current_time + 1.hour
        if new_time.hour >= 2 && new_time.hour < 17
          @game.update(current_time: new_time.change(hour: 17), day: @game.day + 1)
        else
          @game.update(current_time: new_time)
        end
      end
    end
  end