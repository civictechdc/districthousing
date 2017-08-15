FROM ruby:2.1
WORKDIR /app
ADD . /app
RUN apt-get update && apt-get install --yes build-essential vim pdftk
RUN /app/install-cloud-sdk.sh
RUN bundle install
RUN rake db:setup
RUN rake seed_applicants
RUN rake formsync
RUN rake seed_pdfs
EXPOSE 3000
CMD ["rails", "s"]
