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
    # ActsAsTaggableOn::Tag.most_used(10)
    @moods = policy_scope(Mood).order(created_at: :desc)


    @week_activities_count = activity_frequency(Date.today.beginning_of_week..Date.today.end_of_week).first(10)
    @month_activities_count = activity_frequency(Date.today.beginning_of_month..Date.today.end_of_month).first(10)
    @year_activities_count = activity_frequency(Date.today.beginning_of_year..Date.today.end_of_year).first(10)

  end

  private

  def mood_params
    params.require(:mood).permit(:rating, activity_list: [])
  end

  def activity_frequency(period)
    month = @moods.where(created_at: period)
    month_activities = month.map {|mood| mood.activity_list }.flatten
    activities_count = Hash.new(0)
    month_activities.each { |activity| activities_count[activity] += 1 }
    activities_count.sort_by {|activity, count| count}.reverse
  end
end
