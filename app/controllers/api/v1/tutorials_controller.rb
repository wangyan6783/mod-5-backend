class Api::V1::TutorialsController < ApplicationController
  def create
    @tutorial = Tutorial.find_or_create_by(tutorial_params)
    if @tutorial.valid?
      render json: @tutorial, status: :ok
    else
      render json: {message: "error"}, status: :not_acceptable
    end
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:video_id)
  end
end
