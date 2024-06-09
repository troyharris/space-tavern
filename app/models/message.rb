class Message < ApplicationRecord
  belongs_to :game

  enum message_type: { event: 'event', game_information: 'game_information', tavern_information: 'tavern_information', debug: 'debug' }

  validates :message_type, presence: true, inclusion: { in: message_types.keys }
end
