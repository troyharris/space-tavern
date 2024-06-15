class Game < ApplicationRecord
    # Relationships
    has_many :patrons, dependent: :destroy
    has_many :events, dependent: :destroy
    has_many :messages, dependent: :destroy

    # Validations
    validates :name, presence: true
    validates :day, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :tavern_popularity, :colony_prosperity, :event_probability, numericality: true
    validates :credits, :beer_cost, :beer_sell_price, :beers_in_stock, numericality: { only_integer: true }
    validates :is_event_triggered, inclusion: { in: [true, false] }

    # Callbacks
    before_create :set_default_current_time

    # Methods
    def advance_time
        GameLogic::AdvanceTimeService.new(self).call
    end

    def create_new_game
        GameLogic::CreateNewGameService.new(self).call
    end

    def formatted_time
        current_hour = self.current_time.hour
        period = current_hour >= 12 ? 'pm' : 'am'
        formatted_hour = current_hour % 12
        formatted_hour = 12 if formatted_hour == 0
        "#{formatted_hour}#{period}"
    end

    private

    # Sets the default current_time based on start_hour
    def set_default_current_time(start_hour = 17)
        today = Date.today
        min_time = Time.parse('00:00:00')
        self.current_time = DateTime.new(today.year, today.month, today.day, min_time.hour, min_time.min, min_time.sec) + start_hour.hours
    end

  end
