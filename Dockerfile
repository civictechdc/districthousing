FROM ruby:2.1
WORKDIR /app
ADD . /app
RUN apt-get update && apt-get install --yes build-essential vim pdftk
RUN bundle install
RUN rake db:setup
RUN rake seed_applicants
RUN rake pull_pdfs
EXPOSE 3000
CMD ["rails", "s"]
