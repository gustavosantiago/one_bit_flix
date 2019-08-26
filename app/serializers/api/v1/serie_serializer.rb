class Api::V1::SerieSerializer
  SERIE_TYPE = "serie".freeze

  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :thumbnail_key, :feature_thumbnail_key

  has_many :episodes, record_type: :movies, serializer: :movie

  attribute :type do |object|
    SERIE_TYPE
  end

  attribute :category do |object|
    object.category&.name
  end

  attribute :last_watched_episode do |object|
    object.last_watched_episode_id
  end

  attribute :reviews_count do |object|
    object.reviews&.count || 0
  end

  attribute :favorite do |object|
    if params.present? && params.has_key?(:user)
      params[:user].favorites.where(favoritable: object).exists?
    end
  end
end
