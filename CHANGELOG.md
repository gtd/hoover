## Version 0.0.6 - Oct 26, 2011

* Remove ActionView log subscriber contents (not useful to me, and triggers the loggly hash-in-array bug)
* Polish and specs for ActionController, ActiveResource, and ActionMailer log subscribers (derived from live test
  against Rails 3.0.9
* Send an INFO message to main Rails logger so you can see what was sent to Loggly

## Version 0.0.5 - Oct 24, 2011

* Sanitize hash objects coming in instead of relying on implicit to_json which sometimes crashes.

## Version 0.0.4 - Oct 22, 2011

* Fix some crashes in the middleware

## Version 0.0.3 - Oct 22, 2011

* Remove Jeweler dependency

## Version 0.0.2 - Oct 22, 2011

* Fix for Rails functional testing

## Version 0.0.1 - Oct 22, 2011

* Initial release
* Hoover.add functionality is the core
* Includes LogSubscribers based on Rails 3 internal LogSubscribers
* Tested against a large Rails 3.0.9 app
* Should be considered alpha quality
