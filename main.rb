# coding: utf-8

require 'discordrb'
require 'dotenv'
require 'challonge-api'
require 'securerandom'

Dotenv.load

Challonge::API.username = ENV['CHALLONGE_USERNAME']
Challonge::API.key      = ENV['CHALLONGE_KEY']

bot = Discordrb::Bot.new token: ENV['DISCORD_BOTUSER_TOKEN'], client_id: ENV['DISCORD_APP_CLIENT_ID']

bot.message(content: 'やりますか') do |event|
  begin
    tournament                 = Challonge::Tournament.new
    tournament.url             = SecureRandom.hex(16)
    tournament.name            = '天下一武道会'
    tournament.tournament_type = 'double elimination'
    tournament.quick_advance   = true # undocumented
    raise tournament.errors.full_messages.join("\n") unless tournament.save

    online_member_names = event.server.members.select{|m| m.status == :online && !m.current_bot?}.map{|m| m.username}
    online_member_names.each do |name|
      Challonge::Participant.create(:name => name, :tournament => tournament)
    end

    tournament.start!
  rescue => e
    event.respond <<~EOT
      なにかエラーが起きました・・・。
      ```
      #{e.message}
      ```
    EOT
  else
    event.respond <<~EOT
      #{tournament.full_challonge_url}
    EOT
    event.respond
  end
end

bot.run
