class Api::V1::UsersController < ApplicationController
  def sign_in?
    current_user = user_signed_in?
    render json: current_user
  end
end