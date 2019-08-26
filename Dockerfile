FROM ruby:2.6.3-alpine

RUN apk add --update build-base postgresql-dev tzdata git

RUN apk add --update nodejs yarn

RUN gem install bundler:2.0.2

WORKDIR /one_bit_flix
ADD Gemfile Gemfile.lock /one_bit_flix/

RUN bundle install

EXPOSE 3000
