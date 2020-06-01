class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def community
    @user = User.find(params[:id])
    authorize @user
    @friends = current_user.friends
    @moods = Mood.includes([:taggings]).where(user: @friends).order(created_at: :desc).first(10)
  end
end
