# Stack Exchange Bounty Ad

## Setting Up The Environment

* Use [RVM](https://rvm.io/) or [rbenv](https://github.com/sstephenson/rbenv) to install and manage Ruby 1.9.3
* Run `bundle install` to load up the gems. This part will likely give you lots of grief due to ImageMagick and RMagick2.
* No errors? Fantastic!

## Generating Images

* Sinatra GO: `ruby webapp.rb`
* Browse to [http://localhost:4567/bounty.png?site=apple.stackexchange.com](http://localhost:4567/bounty.png?site=apple.stackexchange.com) (or click the link if you're lazy, I know I am).
* Success!

Oh, feel free to change the site parameter to any fully qualified StackExchange domain. It should always work with any site address that would otherwise browse you to the particular site.

## What now?

I dunno. I think you're done, right?
