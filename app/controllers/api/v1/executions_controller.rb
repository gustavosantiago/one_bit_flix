class Api::V1::ExecutionsController < ApplicationController
  before_action :set_execution, only: :update
  before_action :set_movie, only: :show

  def show
    @player = @movie.find_or_create_by(end_date: nil, user: current_user)

    render json: Api::V1::PlayerSerializer.new(
      @player, include: [:movie]
    ).serialized_json
  end

  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: {
        errors: @player.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:execution).permit(:elapsed_time, :end_date).merge(user: current_user)
  end

  def set_execution
    @player = Player.find_by(movie_id: params[:id])
  end

  def set_movie
    @movie = Movie.find_by(movie_id: params[:id])
  end
end
