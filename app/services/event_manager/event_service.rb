module EventManager
    class EventService
      EVENT_TYPES = [
        ["mundane", 0.5],            # 50% probability
        ["relationship_based", 0.3], # 30% probability
        ["tavern_based", 0.15],      # 15% probability
        ["colony_based", 0.05]       # 5% probability
      ]
      def initialize(game)
        @game = game
      end

      def handle_events
        puts "Handling events for game #{@game.id}"
        check_and_generate_events
      end

      def check_and_generate_events
        visiting_patrons = Patron.where(game_id: @game.id, is_visiting: true)
        if visiting_patrons.count > 0
          puts "There are #{visiting_patrons.count} visiting patrons. Checking for events"
          random_check = rand
          generate_events if random_check < @game.event_probability
        end
      end

      def select_event_type
        # Generate a cumulative distribution
        cumulative = []
        sum = 0.0
        EVENT_TYPES.each do |etype, weight|
          sum += weight
          cumulative << [etype, sum]
        end

        # Generate a random number between 0 and the sum of weights
        rnd = rand * sum

        # Select the event type based on the random number
        cumulative.each do |etype, cumulative_weight|
          return etype if rnd < cumulative_weight
        end
      end

      def generate_events
        #puts "Generating events for game #{game.id}"
        # Logic to generate game events
        event_type = select_event_type
        puts "------------"
        puts GptManager::CreateEvent.new(@game).create_event(event_type)
        puts "------------"
      end
    end
  end