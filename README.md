[![Build Status](https://travis-ci.org/codefordc/districthousing.svg?branch=master)](https://travis-ci.org/codefordc/districthousing)

District Housing
================

District Housing lets caseworkers help clients apply for Section 8 housing by automatically filling out multiple PDF applications using one online form.

This is a [Ruby on Rails](http://rubyonrails.org/) application: knowledge of [Ruby](https://www.ruby-lang.org/) &
[Rails](http://rubyonrails.org/) is recommended to work on the server component, and
[Codecademy's class](http://www.codecademy.com/learn/learn-rails) is a great way to start.

This application uses the [pdf-forms gem](https://github.com/jkraemer/pdf-forms) and [pdftk](http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/).

## Docker Setup

Docker is the easiest way to spin up a local instance of the app for development. If you haven't already, download [Docker](https://www.docker.com/community-edition) and [get it running](https://docs.docker.com/get-started/#setup). 

You can grab the latest pre-built docker image, or build it yourself.

### Get the latest pre-built docker image

Run:

    docker run --detach --publish 3000:3000 gcr.io/mindful-origin-855/github-codefordc-districthousing

### Build the docker image yourself

Clone this repository to your machine by your preferred method. Then open a terminal window and navigate to where you stored the repo.

Run the following commands: (stable wifi recommended but not strictly necessary)

    docker build --tag dh .
    docker run --publish 3000:3000 --rm -t dh

And you're done! Leave the terminal process running and open http://localhost:3000/ in a browser. You will see the app filled with fake applicant data, ready for testing. 

## Setup

The application can generate random seed data for testing.  To get the application up and running, run these commands:

    bundle install
    rake db:setup
    rails server

This will allow you to create an account, and start filling in applicants.

For testing with sample user data, you can run the following command, which will create a test user account with 30 fake applicants:

    rake seed_applicants

The login for the test user is:

    Username: testuser@districthousing.org
    Password: password

Code for DC has labeled additional PDFs to work with District Housing.  These are not stored directly in the Git repository, but you can obtain them with the following command:

    rake pull_pdfs

As a demo, the app can be found at [http://districthousing.org/](http://districthousing.org/).  Don't enter real data here, or rely on your data sticking around.  It's likely to be reset and upgraded without warning.

## Dependencies

### PDFtk

Requires [pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/). On OS X, install [homebrew](http://brew.sh/) and then run:

    brew cask install pdftk

On Debian/Ubuntu:

    sudo apt-get install pdftk

### Wget

On OS X, use homebrew:

    brew install wget

On Debian/Ubuntu:

    sudo apt-get install wget

## Installation with Cloud9

If you do not want to go through the trouble of installing Rails on your machine, you can easily set up the development environment with [Cloud9](https://c9.io/). After forking the districthousing repo, sign up for a free Cloud9 account using your Github credentials.

On the left side of your Cloud9 dashboard Click on repositories, then from the list on the right hand side Select districthousing and click 'Clone to Edit.' Give Workspace name and click on create Workspace. The districthousing will now be listed under 'workspace'. Once workspace created, you can start editing.

To continue using git, run the following in your workspace terminal:

    git remote add districthousing 'git@github.com:[github username]/districthousing'

Ensure that you are using ruby-2.1.2 and install pdftk:

    rvm install ruby-2.1.2
    sudo apt-get update && sudo apt-get install -y pdftk

You should now be able to get the application up by running:

    bundle install
    rake db:setup pull_pdfs seed_applicants
    rails s -b $IP -p $PORT

Navigate to http://districthousing-c9-[username].c9.io to see your app.
