# docker-phpunit
This is a docker image for installing/executing [PHPUnit].

## Purpose
This docker image builds on top of [`nubs/composer-build`][composer-build] and
adds PHPUnit including [xdebug] for code coverage support.  It provides several
key features in addition to those of the base image:

* A `phpunit` installed in the `PATH` at `$COMPOSER_HOME/vendor/bin/phpunit`
  via `composer global require`.  This will always install the newest stable
  version of PHPUnit.
* Xdebug code coverage support.

## Usage
Assuming you have a `phpunit.xml` that specifies your build parameters in a
supported location under your project at `/tmp/my-code`, you can run:

```bash
docker run --interactive --tty --rm --volume /tmp/my-code:/code nubs/phpunit

# Using short-options:
# docker run -i -t --rm -v /tmp/my-code:/code nubs/phpunit
```

This will execute the default command (`phpunit`) and update your code
directory with the result (e.g., code coverage reports).

Other commands can also be executed.  For example, to install composer
dependencies (note this can also be done using [composer-build]):

```bash
docker run -i -t --rm -v /tmp/my-code:/code nubs/phpunit composer install
```

Or to run with custom parameters:

```bash
docker run -i -t --rm -v /tmp/my-code:/code nubs/phpunit phpunit --coverage-html coverage
```

### Dockerfile build
Alternatively, you can create your own `Dockerfile` that builds on top of this
image.  This allows you to modify the environment by installing additional
software needed, altering the commands to run, etc.

A simple one that just installs another package but leaves the rest of the
process alone could look like this:

```dockerfile
FROM nubs/phpunit

USER root

RUN pacman --sync --noconfirm --noprogressbar --quiet php-mongo

USER build
```

You can then build this docker image and run it against your codebase like
normal (this example assumes the `phpunit.xml` and `Dockerfile` are in your
current directory):

```bash
docker build --tag my-code .
docker run -i -t --rm -v "$(pwd):/code" my-code
docker run -i -t --rm -v "$(pwd):/code" my-code phpunit --coverage-html
```

## License
docker-phpunit is licensed under the MIT license.  See [LICENSE](LICENSE) for
the full license text.

[PHPUnit]: http://phpunit.de/
[composer-build]: https://github.com/nubs/docker-composer-build
[xdebug]: http://www.xdebug.org/
