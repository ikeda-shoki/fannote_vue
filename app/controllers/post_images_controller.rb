class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:main, :show]

  def top
  end

  def about
  end

  def use
  end

  def main
  end

  def show
  end

  def index
  end
end
