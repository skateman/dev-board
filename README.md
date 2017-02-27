# Developer Dashboard

[![Dependency Status](https://gemnasium.com/badges/github.com/skateman/dev-board.svg)](https://gemnasium.com/github.com/skateman/dev-board)
[![Docker Automated build](https://img.shields.io/docker/automated/skateman/dev-board.svg)](https://hub.docker.com/r/skateman/dev-board/)

The Developer Dashboard is a Rails application that displays open PRs for a preconfigured repository. It has been tailored for my specific needs, therefore, it might be not convenient for anyone else. However, feel free to open PRs or issues containing your idea how to make it better.

![screen shot 2017-02-27 at 17 49 29](https://cloud.githubusercontent.com/assets/1187051/23370483/1dbf0ab4-fd15-11e6-9c5b-0733a4516c55.png)

## Installation

### Docker container
The application is packed as an all-in-one [docker container](https://hub.docker.com/r/skateman/dev-board/), that can be started by the following command:

```sh
docker run -p 3000:3000 \
  -e SECRET_KEY_BASE="" \
  -e GITHUB_REPO=""     \
  -e GITHUB_USER=""     \
  -e GITHUB_PASS=""     \
  skateman/dev-board
```

The application is configured to listen on port 3000, but this can be [routed to any port](https://docs.docker.com/engine/reference/commandline/run/#/publish-or-expose-port--p---expose) on your local machine. The `SECRET_KEY_BASE` variable is required by Rails and its content has to be a random unique string, you can call `rake secret` from any rails application to generate one. The `GITHUB_` prefixed variables don't need any further explanation, you can generate personal access tokens [on your GitHub settings page](https://github.com/settings/tokens). It is possible to use the application without setting the login credentials, but note that GitHub has more strict [rate limits](https://developer.github.com/v3/#rate-limiting) for unauthorized users.

### Standalone
To run the application outside the container, you will require the following tools:
* Ruby v2.2.2 or newer
* All the dependencies of Rails v5.0.1
* Redis runnin on localhost

After checking out the repository, simply type `bin/setup` in the application's directory to set up all the dependencies. You will have to update the `config/secrets.yml` file with your GitHub credentials and with the `secret_key_base` that can be generated using `bin/rails secret`.

To start both the Rails application and the single-threaded Sidekiq worker, you can use the well known `bin/rails s` and `bin/bundle exec sidekiq` commands. If you don't want to bother with two commands, you can use [Foreman](http://ddollar.github.io/foreman/) by typing:
```sh
bin/bundle exec foreman start
```

Please note that when running outside a container, you will have to create the initial sidekiq job from a Rails console:

```ruby
FetchJob.perform_later
```

## Usage
Simply point your browser at http://localhost:3000. Depending on the repo you will have to wait a few minutes for the initial job to finish. The page is configured to refresh itself in every 120 seconds.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/skateman/dev-board.

## License
The gem is available as open source under the terms of the MIT License.
