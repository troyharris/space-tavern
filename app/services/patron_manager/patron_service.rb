module PatronManager
    class PatronService
      def initialize(game)
        @game = game
      end

      # Check if any patrons are visiting and if they are, check if they are enjoying the tavern
      # If they are not enjoying the tavern, exit them. Don't exit if they have just arrived.
      def check_patron_exits
        patrons = Patron.where(game_id: @game.id, is_visiting: true)
        patrons.each do |patron|
          random_check = rand
          if patron.visit_length > 0 && random_check > patron.enjoys_tavern
            patron.update(is_visiting: false, visit_length: 0)
            MessageManager::MessageService.create_message(@game, :tavern_information, "Patron #{patron.id} is leaving")
          else
            patron.increment!(:visit_length)
          end
        end
      end

      # Check if any patrons are not visiting and if they are, check if they are entering
      def check_patron_entries
        patrons = Patron.where(game_id: @game.id, is_visiting: false)
        patrons.each do |patron|
          random_check = rand
          if random_check < @game.tavern_popularity
            patron.update(is_visiting: true)
            MessageManager::MessageService.create_message(@game, :tavern_information, "Patron #{patron.id} is entering")
          end
        end
      end

      # Check if any patrons are visiting and if they are, check if they are ordering a drink
      def check_patron_drink_orders
        patrons = Patron.where(game_id: @game.id, is_visiting: true)
        patrons.each do |patron|
          if patron.credits > @game.beer_cost && @game.beers_in_stock > 0
            drink_order_probability = (patron.enjoys_tavern + @game.tavern_popularity) / 2
            if rand < drink_order_probability
              patron.update(credits: patron.credits - @game.beer_cost)
              @game.update(beers_in_stock: @game.beers_in_stock - 1, credits: @game.credits + @game.beer_cost)
              MessageManager::MessageService.create_message(@game, :tavern_information, "Patron #{patron.id} is ordering a drink")
            end
          end
        end
      end



      def handle_patrons
        check_patron_entries
        check_patron_exits
        check_patron_drink_orders
      end
    end
  end