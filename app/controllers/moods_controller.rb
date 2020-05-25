class MoodsController < ApplicationController
  def index
    today = Date.today.beginning_of_day..Date.today.end_of_day
    @moods = policy_scope(Mood).order(created_at: :desc).where(created_at: today)
    @average = current_user.average_mood(@moods)
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
    today = Date.parse params[:date]
    @moods = current_user.moods.where(created_at: today.beginning_of_day..today.end_of_day)
    authorize @moods
  end

  def insights
    @moods = policy_scope(Mood).order(created_at: :desc)
  end

  private

  def mood_params
    params.require(:mood).permit(:rating, activity_list: [])
  end
end
