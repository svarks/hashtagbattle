## Hashtag Battle

This is a remake of my first attempt to implement it with Rails.

I decided to go with rails simply because I'm a lot more familiar with it.
But once I started building the prototype it became clear that it's not really a
fit, at least at this point. And rails is not that great when it comes to
many concurrent connections.

And I've also been having some issues with twitter api gem for ruby
(it wouldn't let me close stream connection when client terminate connection)

TODO: add some tests

## Restrictions

Twitter can only support 2 connections at the same time.
So this implementation can only support 2 concurrent users.

If we want more users, we'd probably want to switch to paid 'firehose'
endpoint, or run a background process, and keep adding new tags to it
dynamically. Having two connections available would let us start new connection
while the old one is still running and then just make sure we don't send the
same tweet twice to the client.

Nothing is stored on the server at this point.

### Demo

<http://not-hashtag-battle.herokuapp.com/?one=coffee&two=tea>
<http://not-hashtag-battle.herokuapp.com/?one=who&two=what>

### Installation

```sh
npm install -g bower gulp # link `bower` and `gulp` binaries into `/url/local/bin`
npm install               # install server dependencies
bower install             # install client dependencies
gulp                      # compile static assets
npm strt                  # start the server
```

### Analytics (TODO)

* number of tweets (we can also do timeslot aggregation to build daily / weekly
  distribution graphs)
* try to analaze the tweets (positive / negative)
* see how many of them have both keywords at once
* visits, number of battles per visitor, how long they run it for
