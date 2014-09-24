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

As a demo, the app can be found at http://districthousing.runningen.net/.  Don't enter real data here, or rely on your data sticking around.  It's likely to be reset and upgraded without warning.
