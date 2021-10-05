class Book < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
    
  validates :rate, numericality: {
    only_integer: true,
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end