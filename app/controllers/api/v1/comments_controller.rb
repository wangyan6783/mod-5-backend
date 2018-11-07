class Api::V1::CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: @comment, status: :ok
    else
      render json: {error: "error"}, status: :not_acceptable
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: {error: "error"}, status: :ok
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :event_id, :like_count)
  end
end
