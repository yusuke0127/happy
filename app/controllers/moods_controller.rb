class MoodsController < ApplicationController
  def index
    @moods = policy_scope(Mood).order(created_at: :desc)
  end

  def new
    @mood = Mood.new
    authorize @mood
  end

  def create
    @mood = Mood.new(mood_params)
    @mood.user = current_user
    authorize @mood
    if @mood.save
      redirect_to moods_path
    else
      render :new
    end
  end

  def show
  end

  def insights
    @moods = policy_scope(Mood).order(created_at: :desc)
  end

  private

  def mood_params
    params.require(:mood).permit(:rating, activity_list: [])
  end
end
