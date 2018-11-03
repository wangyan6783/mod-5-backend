class Api::V1::UserEventsController < ApplicationController
  def create
    @user_event = UserEvent.find_by(user_event_params)

    if @user_event
      @user_event = {found: true}
    else
      @user_event = UserEvent.create(user_event_params)
    end

    render json: @user_event, status: :ok
  end

  private
  def user_event_params
    params.require(:user_event).permit(:event_id, :user_id)
  end
end
