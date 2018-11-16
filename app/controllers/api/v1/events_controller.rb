class Api::V1::EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events, status: :ok
  end

  def show
    @event = Event.find(params[:id])
    render json: @event, status: :ok
  end

  def create
    @event = Event.create(event_params)
    if @event.valid?
      # create live chat room for saved events
      @host = User.find(@event[:host_id])
      Rails.configuration.chatkit.create_room({ creator_id: @host[:username], name: @event[:title] })
      # assign chat room id to this event
      rooms = Rails.configuration.chatkit.get_user_rooms({ id: @host[:username] })
      room = rooms[:body].find {|room| room[:name] == @event[:title]}
      @event.update(chat_room_id: room[:id])

      render json: @event, status: :ok
    else
      render json: {message: "error"}, status: :not_acceptable
    end
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :date, :image_url, :resort_id, :host_id)
  end

end
