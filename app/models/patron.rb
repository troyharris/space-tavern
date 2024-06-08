class Patron < ApplicationRecord
  belongs_to :game
  has_and_belongs_to_many :events
  has_many :patron_relationships
  has_many :related_patrons, through: :patron_relationships
end
