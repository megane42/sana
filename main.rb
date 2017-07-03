require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Bot.new token: ENV['DISCORD_BOTUSER_TOKEN'], client_id: ENV['DISCORD_APP_CLIENT_ID']

bot.message(content: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run
