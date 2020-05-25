class Mood < ApplicationRecord
  belongs_to :user

  enum rating: [:awful, :meh, :neutral, :happy, :fabulous]
  acts_as_taggable_on :activities
end
