class Message < ApplicationRecord
  belongs_to :game

  enum message_type: { event: 'event', game_information: 'game_information', tavern_information: 'tavern_information', debug: 'debug' }

  validates :message_type, presence: true, inclusion: { in: message_types.keys }

  def formatted_time
    hour = self.time
    period = hour >= 12 ? 'pm' : 'am'
    formatted_hour = hour % 12
    formatted_hour = 12 if formatted_hour.zero?
    "#{formatted_hour}#{period}"
  end
end
