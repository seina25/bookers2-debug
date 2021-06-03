class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # 被フォロー関係を通じて参照→followed_idをフォローしている人
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 与フォロー関係を通じて参照→follower_idをフォローしている人
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  # フォローする・外す・フォローしているか確認を行うメソッドたち
  # ユーザをフォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # ユーザのフォロー外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしていたらtrueを返す
  def following?(user)
    followings.include?(user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: { in: 2..20 }, uniqueness: true, presence: true
  validates :introduction, length: { maximum: 50 }
end
