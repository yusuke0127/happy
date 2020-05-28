class Mood < ApplicationRecord
  belongs_to :user
  validates :mood, presence: :true

  enum rating: [:awful, :meh, :neutral, :happy, :fabulous]
  acts_as_taggable_on :activities
  def self.activities
    ActsAsTaggableOn::Tag.all.map { |tag| tag.name }
  end
end
