class MoodsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new_smiley]


  def index
    today = Date.today.beginning_of_day..Date.today.end_of_day
    @moods = policy_scope(Mood).order(created_at: :desc).includes([:taggings]).where(created_at: today)
    # average for today
    @average = current_user.average_mood_for(Date.today)
    # weekly average mood
    @week_moods = current_user.weekly_average_moods
    # 7 days ago
    @streak_days = current_user.one_week_mood


    @five_good_activities = good_activities.first(5).map {|frequency| frequency[0]}
    @todays_activities = @moods.map {|mood| mood.activity_list}.flatten
    @friends = current_user.friends
    @message = create_message(@average)

  end

  def calendar
    @moods = policy_scope(Mood)
  end


  def new_smiley
    @mood = Mood.new
    @rating = params[:rating]
    authorize @mood
  end

  def habits
    fab_moods = policy_scope(Mood).includes(:taggings).where(rating: "fabulous")
    activities = fab_moods.map { |mood| mood.activity_list }.flatten
    @activity_frequency = frequency(activities)

    awful_moods = policy_scope(Mood).includes(:taggings).where(rating: "awful")
    bad_activities = awful_moods.map { |mood| mood.activity_list }.flatten
    @bad_activity_frequency = frequency(bad_activities)

    this_week = Date.today.beginning_of_week..Date.today.end_of_week
    last_week = (Date.today - 6).beginning_of_week..(Date.today - 6).end_of_week

    average_moods_current_week = current_user.moods.where(created_at: (this_week)).average(:rating)&.round

    if average_moods_current_week != nil
      @this_week_mood = Mood.ratings.keys[average_moods_current_week]
    end

    average_moods_last_week = current_user.moods.where(created_at: (last_week)).average(:rating)&.round
    if average_moods_last_week != nil
      @last_week_mood = Mood.ratings.keys[average_moods_last_week]
    end
  end


  def new
    # @rating = params.has_key?(:rating) ? params[:rating]
    @mood = Mood.new(rating: params[:rating])
    authorize @mood
  end

  def create
    @mood = Mood.new(mood_params)
    @mood.user = current_user
    authorize @mood
    if params[:mood][:custom_activities]
      params[:mood][:custom_activities].each do |activity|
        @mood.activity_list.add(activity)
      end
    end
    if @mood.save
      redirect_to moods_path
    else
      render :new
    end
  end

  def show
    today = Date.parse params[:date]
    @moods = current_user.moods.where(created_at: today.beginning_of_day..today.end_of_day).order(created_at: :asc).includes([:taggings])
    authorize @moods
  end

  def insights
    @moods = policy_scope(Mood).order(created_at: :desc).includes([:taggings])
    @week_activities_count = activity_frequency((Date.today - 6).beginning_of_week..(Date.today - 6).end_of_week).first(5)
    @month_activities_count = activity_frequency(Date.today.beginning_of_month..Date.today.end_of_month).first(5)
    @year_activities_count = activity_frequency(Date.today.beginning_of_year..Date.today.end_of_year).first(5)

    @week_hash = create_week_hash((Date.today - 6).beginning_of_week..(Date.today - 6).end_of_week)
    @month_hash = create_month_hash(Date.today.beginning_of_month..Date.today.end_of_month)


    @year_hash = create_year_hash(Date.today - 1.year, Date.today)

  end

  private

  def mood_params
    params.require(:mood).permit(:rating, :note, activity_list: [])
  end

  def activity_frequency(period)
    month = @moods.where(created_at: period)
    month_activities = month.map {|mood| mood.activity_list }.flatten
    activities_count = Hash.new(0)
    month_activities.each { |activity| activities_count[activity] += 1 }
    activities_count.sort_by {|activity, count| count}.reverse
  end

  def create_week_hash(period) ####
    hash = {}
    week = (period).to_a  #[Mon]
    week_moods = current_user.week_average_mood(period)
    week.each_with_index do |date, index|
      if Mood.ratings[week_moods[index]].nil?
        hash[date.strftime("%a")] = 0
      else
        hash[date.strftime("%a")] = Mood.ratings[week_moods[index]]
      end
    end
    hash
  end

  def create_month_hash(period)
    hash = {}
    first_day_of_month = Date.today.beginning_of_month
    first_week = first_day_of_month.beginning_of_week..first_day_of_month.end_of_week
    first_week_average = create_week_hash(first_week).values.sum/7.0.round
    hash["1st Week"] = first_week_average

    first_day_of_2nd_week = first_day_of_month + 7
    second_week = first_day_of_2nd_week.beginning_of_week..first_day_of_2nd_week.end_of_week
    second_week_average = create_week_hash(second_week).values.sum/7.0.round
    hash["2nd Week"] = second_week_average

    first_day_of_3rd_week = (first_day_of_month + 14)
    third_week = first_day_of_3rd_week.beginning_of_week..first_day_of_3rd_week.end_of_week
    third_week_average = create_week_hash(third_week).values.sum/7.0.round
    hash["3rd Week"] = third_week_average

    first_day_of_4th_week = (first_day_of_month + 21)
    fourth_week = first_day_of_4th_week.beginning_of_week..first_day_of_4th_week.end_of_week
    fourth_week_average = create_week_hash(fourth_week).values.sum/7.0.round
    hash["4th Week"] = fourth_week_average

    first_day_of_5th_week = (first_day_of_month + 28)
    fifth_week = first_day_of_5th_week.beginning_of_week..first_day_of_5th_week.end_of_week
    fifth_week_average = create_week_hash(fifth_week).values.sum/7.0.round
    hash["5th Week"] = fifth_week_average
    return hash
  end

  def create_year_hash(start_date, end_date)
    hash = {}
    first_days = []
    next_month = start_date
    until next_month > end_date
      first_days << Date.new(next_month.year, next_month.month)
      next_month += 1.month
    end
    periods = first_days.map do |first_of_month|
      first_of_month..first_of_month.end_of_month
    end
    periods.each do |period|
      average = create_week_hash(period).values.sum/7.0.round
      hash[Date::MONTHNAMES[period.first.month]] = average
    end
    hash
  end

  def frequency(array)
    result = Hash.new(0)
    array.each do |item|
      result[item] += 1
    end
    return result.sort_by { |activity, count| count }.reverse
  end

  def good_activities
    fab_moods = policy_scope(Mood).includes(:taggings).where(rating: "fabulous")
    activities = fab_moods.map { |mood| mood.activity_list }.flatten
    @activity_frequency = frequency(activities)
  end

  def create_message(average)
    case average
    when "awful"
      message = "Don't give up! "
    when "meh"
      message = "Love yourself more, silly! "
    when "neutral"
      message = "You can achieve more! "
    when "happy"
      message = "You're doing good! "
    when "fabulous"
      message = "Your best day yet! "
    end
    message
  end


end
