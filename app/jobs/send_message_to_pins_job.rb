class SendMessageToPinsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    @client ||= Line::Bot::Client.new do |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
     config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    text = "You have an upcoming event (Demo Day) today! \n How are you feeling? \nGo to https://www.happyyou.xyz/ and log your mood!"
    message = {
      type: 'text',
      text: text
    }
    # sticker message json
    message_sticker {
      type: sticker,
      packageId: '11537',
      stickerId: '52002745'
    }
    @client.push_message(user.line_id, message)
    # send sticker
    @client.push_message(user.line_id, message_sticker)

  end
end
