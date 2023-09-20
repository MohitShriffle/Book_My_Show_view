class Show < ApplicationRecord
  belongs_to :movie
  belongs_to :screen
  has_many :tickets, dependent: :destroy
  validates :screen_id, uniqueness: { scope: :movie_id }

end
