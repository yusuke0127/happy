class User < ApplicationRecord
  has_many :moods, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def average_mood(given_moods)
    return nil unless given_moods.any?

    integer = (moods.where(id: given_moods).pluck(:rating).map { |rating| Mood.ratings.keys.index(rating) }.sum / moods.where(id: given_moods).count.to_f).round
    Mood.ratings.keys[integer]
  end

  def daily_average_mood
    (0..6).to_a.map do |number|
      days_mood = moods.where(created_at: (Date.today - number.day).beginning_of_day..(Date.today - number.day).end_of_day)
      average_mood(days_mood)
    end
  end

  def one_week_mood
    Date.today.beginning_of_week..Date.today.end_of_week
  end
end
