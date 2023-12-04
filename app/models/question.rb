class Question < ApplicationRecord
  validates :question, presence: true, uniqueness: true
  has_neighbors :embedding 
end
