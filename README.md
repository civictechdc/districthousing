District Housing
================

The District Housing app aids DC residents and case workers apply for Section 8 housing by empowering them to automatically fill out multiple Section 8 housing applications using information collected via an online form.  Data collected once for a person can be used to populate PDF versions of housing applications.

This application uses the [pdf-forms gem](https://github.com/jkraemer/pdf-forms) and [pdftk](http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/).

The application can generate random seed data for testing.  To get the application up and running with seed data, run these commands:

    bundle install
    rake db:setup
    rails server

The seed data creates a test user account with information pre-populated.  The login for the test user is:

    Username: testuser@districthousing.org
    Password: password

As a demo, the app can be found at http://districthousing.org/.  Don't enter real data here, or rely on your data sticking around.  It's likely to be reset and upgraded without warning.

## Dependencies

Requires pdftk.  On OS X:

    brew cask install pdftk

On Debian/Ubuntu:

    apt-get install pdftk

## Installation with Cloud9

If you do not want to go through the trouble of installing Rails on your machine, you can easily set up the development environment with [Cloud9](https://c9.io/). After forking the districthousing repo, sign up for a free Cloud9 account using your Github credentials.

Your fork of districthousing should appear on the left side of your Cloud9 dashboard under 'Projects on Github.' Select it and click 'Clone to Edit.' Choose the pre-configured Ruby on Rails environment. The districthousing fork will now be listed under 'My Projects.' Once cloned, click 'Start Editing.'

To continue using git, run the following in your workspace terminal:

    git remote add districthousing 'git@github.com:[github username]/districthousing'

Install pdftk using apt-get and ensure that you are using ruby-2.1.2. You should now be able to get the application up by running:

    bundle install
    rake db:setup
    rails s -b $IP -p $PORT
    
