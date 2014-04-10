# Checkable

A simple runner for checks, kind of like unit tests for user data, for cases
where Rails validations won't cut the mustard. Runs a set of "checks" against
your objects and lets you know what passes and what fails. Use the report as
a basis for proposing fixes to your users.

## Installation

Add this line to your application's Gemfile:

    gem 'checkable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checkable

## Usage

A "check" is an object that responds to #check with one argument, the object to check.
This method returns true if the check passes, and false if the check fails. Register your
check by calling Checkable.register(target_type_name, check_instance)

See specs for some more details.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/checkable/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
