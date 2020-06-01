class User < ApplicationRecord
  has_friendship
  has_many :moods, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]


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

  def week_average_mood(week_period)
    this_week = (week_period).to_a
    this_week.map do |date|
      average_mood_for(date)
    end

    # (Date.today.beginning_of_week..Date.today.end_of_week).to_a.map do |date|
    #   days_mood = moods.where(created_at: date.beginning_of_day..date.end_of_day)
    #   average_mood(days_mood)
    # end
  end
  # def self.find_for_google_oauth2(auth)
  #   data = auth.info
  #   if validate_email(auth)
  #     user = User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #       user.provider = auth.provider
  #       user.uid = auth.uid
  #       user.email = auth.info.email
  #       user.password = Devise.friendly_token[0,20]
  #     end
  #     user.token = auth.credentials.token
  #     user.refresh_token = auth.credentials.refresh_token
  #     user.save
  #     return user
  #   else
  #     return nil
  #   end
  # end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(
        name: data["name"],
        email: data["email"],
        encrypted_password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
