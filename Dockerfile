FROM ruby:2.1.2

RUN apt-get update \
 && apt-get install -y build-essential pdftk wget

ENV APP_HOME /districthousing
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install app dependencies
ADD Gemfile* $APP_HOME/
RUN bundle install

# Install application source
ADD . $APP_HOME

# Setup the database
RUN rake db:setup

# Command to run on startup
CMD ["rails", "server"]
