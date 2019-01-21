# Rockburg
Rockburg is a music industry simulation game that I've had brewing in my ([@Shpigford](https://twitter.com/Shpigford)) head for years.

Back in the early 2000's I was super in to this game called Project Rockstar and it met an untimely death thanks to trademark issues with their name. Poor guys.

Ultimately what I'm trying to do here is build a fun, modern simulation game. I have no idea what I'm doing, so all input is more than welcome!

## Playing the game
You can access the super-extra-alpha version of the game now: https://alpha.rockburg.com

But beware it will frequently be wiped clean until we officially launch.

## Codebase
The current codebase is vanilla Rails. Really nothing out of the ordinary here.

![image](https://circleci.com/gh/Rockburg/rockburg.svg?style=shield&circle-token=:circle-ci-badge-token)

## Local setup

You need to have redis installed to run sidekiq: [follow installation instructions here](https://redis.io/download#installation)

```bash
$ bundle && rake db:setup # sets up the database and loads seed data
$ bundle exec puma # starts webserver

# in another console tab...
$ redis-server & sidekiq # required for background jobs, which much of the app relies on
```

## Contributing
It's still very early days for this. It doesn't exist on any public servers yet...all dev work is still just local. So, your mileage will vary here and lots of things will break.

But almost any contribution will be beneficial at this point as all the work I've done has been sledgehammer type stuff instead of details.

If you've got an improvement, just send in a pull request. If you've got feature ideas, simply [open a new issues](https://github.com/withspectrum/spectrum/issues/new)!

### Chat
We've set up a Slack channel for development (and general game discussion): http://chat.rockburg.com

## License & Copyright
Released under the MIT license, see the [LICENSE](./LICENSE) file. Copyright (c) 2019 Sabotage Media LLC.
