class Book < ApplicationRecord
  has_one_attached :profile_image
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body,  presence: true, length: { maximum: 200 }

  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end

  #投稿数を日付別に表示する方法 scope :スコープの名前, -> { 条件式 }
  #scopeとは、モデルに処理を定義することで、コントローラー等での記述を簡潔にする作業の事。イメージとしてはショートカットアイコンを作るような物でしょうか？
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日 ｛どこ（作成日：タイムゾーン．今.すべて）｝
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日 ｛どこ（作成日：タイムゾーン．昨日.すべて）｝
  scope :created_this_week, -> { where(created_at: Time.current.all_week) } # 今日 ｛どこ（作成日：タイムゾーン．今.すべて）｝
  scope :created_last_week, -> { where(created_at: Time.current.last_week.all_week) } # 前日 ｛どこ（作成日：タイムゾーン．昨日.すべて）｝
  scope :created_day, ->(n) {where(created_at: n.days.ago.all_day)} #日付をnとして n.days.ago.all_day とすればn日前の日付が求められる
end
