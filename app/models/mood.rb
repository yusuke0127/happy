class Mood < ApplicationRecord
  belongs_to :user

  enum rating: [:awful, :meh, :neutral, :happy, :fabulous]
  acts_as_taggable_on :activities
  def self.activities
    ActsAsTaggableOn::Tag.all.map { |tag| tag.name }
  end
end
