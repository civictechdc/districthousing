FROM ruby:2.1
WORKDIR /app
ADD . /app
RUN apt-get update && apt-get install --yes build-essential vim pdftk
RUN curl https://sdk.cloud.google.com | bash
RUN /root/google-cloud-sdk/install.sh --command-completion true --path-update true --usage-reporting false --quiet
RUN bundle install
RUN rake db:setup
RUN rake seed_applicants
# The formsync task execs gsutil, which isn't on the default PATH. Run with
# bash -l to source .bashrc, which was modified by the Cloud SDK installer to
# put SDK executables on the PATH.
RUN bash -l -c "rake formsync"
RUN rake seed_pdfs
EXPOSE 3000
CMD ["rails", "s"]
