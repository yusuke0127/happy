class SendFriendMessageJob < ApplicationJob
  queue_as :default

  def perform(user_id, friend_name)
    user = User.find(user_id)

    @client ||= Line::Bot::Client.new do |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
     config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    text = "Hey, your friend #{friend_name} feels unhappy today... \n Send them a message to cheer them up!"
    message = {
      type: 'text',
      text: text
    }
    @client.push_message(user.line_id, message)
  end
end
