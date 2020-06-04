class SendMoodEventJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    @client ||= Line::Bot::Client.new do |config|
     config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
     config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    text = "Hey how was the event? Go to https://happyyou.xyz/ and log your mood!"
    message = {
      type: 'text',
      text: text
    }
    # sticker message json
    message_sticker {
      type: 'sticker',
      packageId: '11538',
      stickerId: '51626496'
    }
    @client.push_message(user.line_id, message)
    # send stickers
    @client.push_message(user.line_id, message_sticker)

  end
end

#migration for line_id string?
#add line_cahhnel secret
#add Channel access token
