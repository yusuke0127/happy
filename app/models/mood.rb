class Mood < ApplicationRecord
  belongs_to :user
  after_create :send_message_to_friends

  enum rating: [:awful, :meh, :neutral, :happy, :fabulous]
  acts_as_taggable_on :activities
  def self.activities
    ActsAsTaggableOn::Tag.all.map { |tag| tag.name }
  end



  def send_message_to_friends
    line_friends = user.friends.where.not(line_id: nil)
    if user.moods.last.rating == "awful"
      line_friends.each do |friend|
        SendFriendMessageJob.perform_now(friend.id, user.id)
      end
    end
  end
end
