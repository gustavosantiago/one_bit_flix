class DashboardService

  def initialize(type, user)
    @type = type
    @user = user
  end

  def perform
    send("group_by_#{@type}")
  end

  def group_by_category
    categories = Category.includes(:movies, :series)
    Api::V1::CategorySerializer.new(categories)
  end

  def group_by_keep_watching
    players = Player.includes(:movie).where(end_date: nil, user: @user)
    movies = players.map(&:movie)
    Api::V1::MovieSerializer.new(movies)
  end

  def group_by_highlight
    highlight = get_highlighted_movies
    highlight ||= get_highlighted_series
    Api::V1::WatchableSerializer.new(highlight, params: { user: @user })
  end

  def get_highlighted_movies
    Movie.find_by(highlighted: true)
  end

  def get_highlighted_series
    Serie.find_by(highlighted: true)
  end
end
