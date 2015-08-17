[![Build Status](https://travis-ci.org/codefordc/districthousing.svg?branch=master)](https://travis-ci.org/codefordc/districthousing)

District Housing
================

District Housing lets caseworkers help clients apply for Section 8 housing by automatically filling out multiple PDF applications using one online form.

This is a [Ruby on Rails](http://rubyonrails.org/) application: knowledge of [Ruby](https://www.ruby-lang.org/) &
[Rails](http://rubyonrails.org/) is recommended to work on the server component, and
[Codecademy's class](http://www.codecademy.com/learn/learn-rails) is a great way to start.

This application uses the [pdf-forms gem](https://github.com/jkraemer/pdf-forms) and [pdftk](http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/).

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

Your fork of districthousing should appear on the left side of your Cloud9 dashboard under 'Projects on Github.' Select it and click 'Clone to Edit.' Choose the pre-configured Ruby on Rails environment. The districthousing fork will now be listed under 'My Projects.' Once cloned, click 'Start Editing.'

To continue using git, run the following in your workspace terminal:

    git remote add districthousing 'git@github.com:[github username]/districthousing'

Install pdftk using apt-get and ensure that you are using ruby-2.1.2. You should now be able to get the application up by running:

    bundle install
    rake db:setup pull_pdfs seed_applicants
    rails s -b $IP -p $PORT

Navigate to http://districthousing-c9-[username].c9.io to see your app.
