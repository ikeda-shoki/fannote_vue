class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:main]

  def top
  end

  def about
  end

  def use
  end

  def main
  end
end
