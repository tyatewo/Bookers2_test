class Book < ApplicationRecord
  has_one_attached :profile_image
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body,  presence: true, length: { maximum: 200 }

  #投稿数を日付別に表示する方法 scope :スコープの名前, -> { 条件式 }

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日 ｛どこ（作成日：タイムゾーン．今.すべて）｝
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日 ｛どこ（作成日：タイムゾーン．昨日.すべて）｝

end
