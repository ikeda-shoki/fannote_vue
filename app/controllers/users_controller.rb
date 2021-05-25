class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :following, :followed]

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |guest|
      guest.user_name = "ゲスト太朗"
      guest.account_name = "ゲスト"
      guest.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    redirect_to main_post_images_path
  end

  def show
  end

  def index
  end

  def following
  end

  def followed
  end

  def withdrawal
  end

end
