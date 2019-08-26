class Movie < ApplicationRecord
  include PgSearch
  include Highlightable

  multisearchable against: [:title], if: lambda{ |record| record.serie.nil?}

  has_many :reviews, as: :reviewable
  has_many :players, dependent: :destroy

  has_one :watched_serie, class_name: "Serie", foreign_key: "last_watched_episode_id", dependent: :nullify

  belongs_to :serie, optional: true
  belongs_to :category, optional: true

  validate :highlight_episode
  validates :title, :description, :thumbnail_key, :video_key, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :serie_id }, if: -> { serie.present? }

  private

  def highlight_episode
    if serie.present? && highlighted == true
      errors.add(:highlight_episode, "It's not possible to highlight an serie episode")
    end
  end
end
