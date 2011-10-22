Hoover
======

Hoover is the name of [Loggly](http://loggly.com)'s lovable and profane [mascot](http://www.facebook.com/hooverloggly).  It is also the name of this Ruby library.

The purpose of this gem is to take advantage of Loggly's awesome JSON logging (see the [blog post](http://loggly.com/blog/2011/06/on-the-way-to-impressive/)).  Why so awesome?  Because instead of just logging strings, now you can push JSON data, and that data is then exposed to advanced search operations in Loggly's console.  If you've ever spent any time grepping over gigabytes of logfiles to debug some issue or another the benefit of this should be immediately obvious.

Of course, the existing gem [logglier](https://github.com/freeformz/logglier) already supports pushing to the JSON API, so what's Hoover all about?

The foundation of Hoover is a hook into the request lifecycle, so that at the beginning of each request, an empty hash
is created which you can you can easily push data into to be logged.  This is managed by a Rack middleware, guaranteeing
availability throughout the request, and also supplementing with some standard information.

If you are using Rails 3, then there are prewritten log subscribers that pass most of the information that is written to
the normal rails log in a simplified and convenient JSON format.


## Installation

You're using bundler right?

    gem 'hoover'


## Rails Setup

When using Rails 3, the Railtie automatically sets up the Rack middleware, and the log subscribers.  All you need to do
in this case is provide the configured logglier object.  Currently this is done with a class method in your controller:

    class ApplicationController < ActionController::Base
      set_hoover_logglier $loggly
    end

Where `$loggly` is an instance of the `Logglier` class that was set up previously.  Soon I hope to have configuration
options so you can set this in your application.rb.


## General Setup

For other Rack frameworks, you need to add the `Hoover::RackLogger` middleware to your stack.  There is no automated
logging for any framework other than Rails 3.


## Usage

Anywhere in your request you can now call:

    Hoover.add(:key => 'data that converts nicely to json')

If you add with the same key more than once, Hoover automatically rolls it up into an array so you don't lose anything.


## Todo

* Write tests for Rails components
* Provide config option to set the logglier during initialization
* Provide config option to choose which log subscribers to enable


## Contributing to Hoover
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise
  necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.


## Copyright

Copyright (c) 2011 Gabe da Silveira. See LICENSE.txt for further details.

