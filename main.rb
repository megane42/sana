# coding: utf-8

require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Bot.new token: ENV['DISCORD_BOTUSER_TOKEN'], client_id: ENV['DISCORD_APP_CLIENT_ID']

bot.message(content: 'Ping!') do |event|
  online_member_names = event.server.members.select{|m| m.status == :online}.map{|m| m.username}
  event.respond 'Pong!'
end

bot.run
