class Message < ApplicationRecord
  belongs_to :game

  enum type: { event: 'event', game_information: 'game_information', tavern_information: 'tavern_information', debug: 'debug' }

  validates :type, presence: true, inclusion: { in: types.keys }
end
