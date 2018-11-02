class Api::V1::ResortsController < ApplicationController

  def index
    @resorts = Resort.all
    render json: @resorts, status: :ok
  end

  def show
    @resort = Resort.find(params[:id])
    render json: @resort, status: :ok
  end
end
