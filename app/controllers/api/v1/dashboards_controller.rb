class Api::V1::DashboardsController < ApplicationController
  WHITELIST = %i(category keep_watching highlight).freeze

  def index
    type_params and (return if performed?)

    result = DashboardService.new(params[:type], current_user).perform

    render json: result
  end

  private

  def type_params
    params[:type] ||= "category"
    type_whitelist
  end

  def type_whitelist
    unless WHITELIST.include?(params[:type])

      render json: {
        error: "Unpermitted type parameter"
      }, status: :forbidden
  end
end
