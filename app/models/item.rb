class Item < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  with_options presence: true, length: { maximum: 140 } do
    validates :title
    validates :body
  end
  
 
  has_many :favorites, dependent: :destroy 
end
