class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:name]

  has_one_attached :profile_image

  # 同じメールアドレス、同じアカウント名は保存されない
  validates :email, uniqueness: true
  validates :name, uniqueness: true

  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # 通知
  has_many :notifications, dependent: :destroy
  
  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォロー・フォロワー一覧で使用
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  # ブロックした、されたの関係
  has_many :blockers, class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :blockeds, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy
  # ブロックしたユーザー一覧で使用
  has_many :blocking_users, through: :blockers, source: :blocked

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
  # フォローを解除する時
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  # フォローしているかの確認（フォローしていればtrueを返す）
  def following?(user)
    following_users.include?(user)
  end
  # ブロックした時
  def block(user_id)
    blockers.create(blocked_id: user_id)
  end
  # ブロックを解除するとき
  def unblock(user_id)
    blockers.find_by(blocked_id: user_id).destroy
  end
  # ブロックしているかの確認
  def blocking?(user)
    blocking_users.include?(user)
  end
end
