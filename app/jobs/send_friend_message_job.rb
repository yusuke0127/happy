class SendFriendMessageJob < ApplicationJob
  queue_as :default

  def perform(user_id, friend_id)
    user = User.find(user_id)
    friend = User.find(friend_id)

    @client ||= Line::Bot::Client.new do |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
     config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    text = "Hey, your friend #{friend.name} is feeling awful today... \n Send them a message to cheer them up!"
    message = {
      type: 'text',
      text: text
    }
    @client.push_message(user.line_id, message)
  end
end
