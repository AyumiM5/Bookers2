class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  #自分がフォローする側の関係性→follower_idを指定する事で、followed_idが返ってくる
  has_many :active_relationships,  class_name:  "Relationship", foreign_key: "follower_id", dependent:   :destroy
  #自分がフォローされる側の関係性→followed_idを指定する事で、follower_idが返ってくる
  has_many :passive_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent:   :destroy
  #被フォロー関係を通じて参照→active_relationshipsを経由して、自分がフォローしている人の一覧を配列(followig)にする
  has_many :following, through: :active_relationships,  source: :followed
  #被フォロー関係を通じて参照→passive_relationshipsを経由して、自分をフォローしている人の一覧を配列(follower)にする
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 } 
  
  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
  
end
