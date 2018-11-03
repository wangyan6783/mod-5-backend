class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events, status: :ok
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: @event, status: :ok
    else
      render json: {error: "error"}, status: :ok
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :image_url, :resort_id, :host_id)
  end

end
