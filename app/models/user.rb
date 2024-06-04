class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]

  # 同じメールアドレス、同じアカウント名は保存されない
  validates :email, uniqueness: true
  validates :name, uniqueness: true

  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォロー・フォロワー一覧で使用
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_one_attached :profile_image

  # プロフィール画像が設定されていない時の処理
  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      'no_image.jpg'
    end
  end

  # フォローした時
  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  # フォロー外す時
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  # フォローしているかの確認（フォローしていればtrueを返す）
  def following?(user)
    following_users.include?(user)
  end

end
