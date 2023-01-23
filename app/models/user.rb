class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  mount_uploader :profile_image, ProfileImageUploader
  
  has_many :items, dependent: :destroy
  has_many :comments
  
  validates :username, presence: true, length: { maximum: 140 }
  validates :profile, length: { maximum: 140 }
  

  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  has_many :favorites, dependent: :destroy     # ユーザー/お気に入り → 1:多
  has_many :favorite_items, through: :favorites, source: :item
  
  def favorite(item)
     favorite_items << item
  end

  def unfavorite(item)
     favorite_items.destroy(item)
  end

  def favorite?(item)
     favorite_items.include?(item)
  end
  
  
  
end
