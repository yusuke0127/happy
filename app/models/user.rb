class User < ApplicationRecord
  has_many :moods, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  # same as average_mood_for below
  # def average_mood(given_moods)
  #   return nil unless given_moods.any?

  #   integer = (moods.where(id: given_moods).pluck(:rating).map { |rating| Mood.ratings.keys.index(rating) }.sum / moods.where(id: given_moods).count.to_f).round
  #   Mood.ratings.keys[integer]
  # end

  # same as weekly_average_moods below
  # def daily_average_mood
  #   (0..6).to_a.map do |number|
  #     days_mood = moods.where(created_at: (Date.today - number.day).beginning_of_day..(Date.today - number.day).end_of_day)
  #     average_mood(days_mood)
  #   end
  # end

  def one_week_mood
    ((Date.today - 6)..Date.today).to_a
  end

  def average_mood_for(day)
    results = moods.where('DATE(created_at) = ?', day)
    return nil if results.empty?
    average = results.average(:rating).round
    Mood.ratings.keys[average]
  end

  def weekly_average_moods
    (0..6).to_a.map do |number|
      average_mood_for(Date.today - number)
    end.reverse
  end

  def week_average_mood
    this_week = (Date.today.beginning_of_week..Date.today.end_of_week).to_a
    this_week.map do |date|
      average_mood_for(date)
    end

    # (Date.today.beginning_of_week..Date.today.end_of_week).to_a.map do |date|
    #   days_mood = moods.where(created_at: date.beginning_of_day..date.end_of_day)
    #   average_mood(days_mood)
    # end
  end

end
