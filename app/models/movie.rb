class Movie < ApplicationRecord
   has_many :shows ,dependent: :destroy
   has_one_attached :poster
   validates :name, presence: true

   def poster_url
      Rails.application.routes.url_helpers.rails_blob_url(self.poster, only_path: true)
   end
end
