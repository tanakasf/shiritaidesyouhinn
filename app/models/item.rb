class Item < ApplicationRecord
   belongs_to :genre
   has_many :users
   has_many :item_comments, dependent: :destroy
   has_many :favorites, dependent: :destroy
   has_one_attached :image

   validates :image, presence: true
   validates :name, presence: true
   validates :explanation, presence: true
   validates :genre_id, presence: true

   def favorited?(user)
     favorites.where(user_id: user.id).exists?
   end
end
