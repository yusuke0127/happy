class User < ApplicationRecord
  has_many :moods, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def average_mood(given_moods)
    integer = (moods.where(id: given_moods).pluck(:rating).map { |rating| Mood.ratings.keys.index(rating) }.sum / moods.where(id: given_moods).count.to_f).round
    Mood.ratings.keys[integer]
  end

end
