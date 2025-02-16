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
        # puts "There are #{visiting_patrons.count} visiting patrons. Checking for events"
        #MessageManager::MessageService.create_message(
        #  @game,
        #  :debug,
        #  "Checked and generated events for game #{@game.id}"
        #)
        random_check = rand
        generate_event if random_check < @game.event_probability
      end
    end

    def select_event_type
      # Generate a cumulative distribution
      cumulative = []
      sum = 0.0
      EVENT_TYPES.each do |etype, weight|
        # Skip relationship_based event if there are less than 2 visiting patrons
        next if etype == "relationship_based" && Patron.where(game_id: @game.id, is_visiting: true).count < 2
        
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

    def generate_gpt_event
      #puts "Generating events for game #{game.id}"
      # Logic to generate game events
      event_type = select_event_type
      GptManager::CreateEvent.new(@game).create_event(event_type)
    end

    def generate_event
      event = generate_gpt_event
      event_data = {
        day: @game.day,
        time: @game.current_time.strftime("%H:%M"),
        event_type: event["event_type"],
        description: event["event_description"],
        game_id: @game.id,
        credits_change: event.dig("financial_impact", "credits_change") || 0,
        beer_cost_change: event.dig("financial_impact", "beer_cost_change") || 0,
        financial_reason: event.dig("financial_impact", "reason")
      }
      
      event_obj = Event.create(event_data)
      
      # Apply financial impact if present
      if event_obj.credits_change != 0 || event_obj.beer_cost_change != 0
        financial_service = GameLogic::FinancialService.new(@game)
        financial_result = financial_service.apply_financial_event(
          credits_change: event_obj.credits_change, 
          beer_cost_change: event_obj.beer_cost_change,
          reason: event_obj.financial_reason
        )
        
        if financial_result[:success]
          MessageManager::MessageService.create_message(
            @game,
            :game_information,
            financial_result[:message]
          )
        end
      end
      
      save_event_message(event_obj)
    end

    def save_event_message(event)
      message_content = "Event Type: #{event.event_type}, Description: #{event.description}"
      if event.credits_change != 0 || event.beer_cost_change != 0
        message_content += "\nFinancial Impact:"
        message_content += " #{event.credits_change} credits" if event.credits_change != 0
        message_content += " | Beer cost change: #{event.beer_cost_change}" if event.beer_cost_change != 0
        message_content += " (#{event.financial_reason})"
      end
      MessageManager::MessageService.create_message(
        @game,
        :event,
        message_content
      )
    end
  end
end
