class Api::V1::UsersController < ApplicationController
  def sign_in
    sign_in = user_signed_in?
    user = current_user
    render json: { signIn: sign_in, curretUser: user }
  end

  def show
    @user = User.find(params[:id])
    @current_user_sign_in = @user.current_user_sign_in?(current_user)
    @count = @user.post_images.count
  end
end