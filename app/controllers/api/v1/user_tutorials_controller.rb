class Api::V1::UserTutorialsController < ApplicationController
  def create
    @user_tutorial = UserTutorial.find_or_create_by(user_tutorial_params)
    if @user_tutorial.valid?
      render json: @user_tutorial, status: :ok
    else
      render json: {message: "error"}, status: :not_acceptable
    end
  end

  private
  def user_tutorial_params
    params.require(:user_tutorial).permit(:tutorial_id, :user_id)
  end
end
