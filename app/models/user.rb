class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower
  
  attachment :profile_image, destroy: false
  #フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  #フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50}
end
