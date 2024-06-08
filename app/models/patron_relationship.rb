class PatronRelationship < ApplicationRecord
    belongs_to :patron
    belongs_to :other_patron, class_name: "Patron"
  end