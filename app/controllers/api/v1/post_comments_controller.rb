class Api::V1::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_image = PostImage.find(params[:post_image_id])
    post_comment = PostComment.new(post_comment_params)
    post_comment.post_image_id = post_image.id
    if post_comment.save
      render json: post_comment.to_json(include: :user), status: :created
      # @post_image.create_notification_post_image_comment(current_user)
    else
      render json: post_comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post_image = PostImage.find_by(id: params[:post_image_id])
    post_comment = PostComment.find_by(id: params[:id], post_image_id: params[:post_image_id])
    if post_comment.destroy
      head :no_content
    else
      render json: post_comment.errors, status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment, :user_id).merge(user_id: current_user.id)
  end
end
