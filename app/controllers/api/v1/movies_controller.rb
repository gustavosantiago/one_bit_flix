class Api::V1::MoviesController < ApplicationController
  before_action :set_movie, only: :show

  def show
    render json: Api::V1::MovieSerializer.new(
      @movie, include: [:episodes],
      params: { user: current_user }
    ).serialized_json
  end

  private

  def set_movie
    @movie = Movie.find_by(id: params[:id])
  end
end
