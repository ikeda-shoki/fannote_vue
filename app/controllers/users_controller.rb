class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def index
  end

  def following
  end

  def followed
  end

end
