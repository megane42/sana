FROM ruby:2.4-alpine
MAINTAINER megane42

RUN apk update && apk upgrade && apk add --no-cache bash git openssh build-base

RUN git clone https://github.com/megane42/sana.git
WORKDIR sana
RUN bundle install

# ENV DISCORD_APP_CLIENT_ID fooooo
# ENV DISCORD_BOTUSER_TOKEN xxxxxx
# ENV CHALLONGE_USERNAME    baaaaa
# ENV CHALLONGE_KEY         xxxxxx

CMD ruby main.rb