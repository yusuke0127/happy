require 'line/bot'

class Api::V1::LineBotController < Api::V1::BaseController
  # skip_before_action :authenticate_user!, only: [:callback]
  # skip_before_action :verify_authenticity_token, only: [:callback]
  before_action :client, only: [:callback]
  skip_after_action :verify_authorized, only: [:callback]
  def callback
    p @client

    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless @client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    events = @client.parse_events_from(body)
    p events
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text

          user_message = event.message['text'].strip
          puts user_message
          if user_message.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i) #email
            bot_response = handle_registration(user_message)
          elsif user_message.match(/.*url.*/i)
            bot_response = { type: 'text', text: "http://www.happyyou.xyz/"}
            # sticker message
            bot_response_sticker ={
              type: 'sticker',
              packageId: '11539',
              stickerId: '52114115'
            }
          else
            bot_response = {
              type: 'text',
              text: "I'm a dumbass bot 🤖.\nCommands I know:\n- emails for registration"
            }
            # sticker message
            bot_response_sticker = {
              type: 'sticker',
              packageId: '11537',
              stickerId: '52002750'
            }
          end
          puts "sending message"
          @client.reply_message(event['replyToken'], bot_response)
          # sending the sticker replies
          puts "sending sticker"
          @client.reply_message(event['replyToken'], bot_response_sticker)
        end
      end
    }
    puts "rendering status"
    render status: 200, json: {}
  end
  private
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
  def handle_registration(email)
    user = User.find_by_email(email)
    if user
      user.line_id = params["events"].first["source"]["userId"]
      user.save
      {
        type: 'text',
        text: "Connected! Line account added to #{email}\n- You can access your acount at http://www.happyyou.xyz/"
      }
      # sticker message
      {
        type: 'sticker',
        packageId: '11537',
        stickerId: '52002745'
      }
    else
      { type: 'text', text: "Sorry. I couldn't find the Happy user with the email of #{email}. Capital letters matter." }
      # sticker message
      {
        type: 'sticker',
        packageId: '11537',
        stickerId: '52002739 '
      }
    end
  end
end
