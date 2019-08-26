class Api::V1::MovieSerializer
  MOVIE_TYPE = "movie".freeze

  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :thumbnail_key,
             :feature_thumbnail_key, :video_key, :serie_id

  has_many :episodes, record_type: :movies, serializer: :movie

  attribute :type do |object|
    MOVIE_TYPE
  end

  attribute :category do |object|
    object.category&.name
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
