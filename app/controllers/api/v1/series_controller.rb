class Api::V1::SeriesController < ApplicationController
  before_action :set_serie, only: :show

  def show
    render json: Api::V1::SerieSerializer.new(
      @serie, include: [:episodes],
      params: { user: current_user }
    ).serialized_json
  end

  private

  def set_serie
    @serie = Serie.find_by(id: params[:id])
  end
end
