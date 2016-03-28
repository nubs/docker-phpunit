FROM nubs/composer-build:latest

MAINTAINER Spencer Rinehart <anubis@overthemonkey.com>

USER root

# Setup phpunit dependencies (including optional)
RUN pacman --sync --refresh --sysupgrade --noconfirm --noprogressbar --quiet && \
    pacman --sync --noconfirm --noprogressbar --quiet xdebug
ADD phpunit-dependencies.ini /etc/php/conf.d/phpunit-dependencies.ini

USER build

# Install the most recent stable phpunit.  This is more or less a fallback for
# the default use case.  It is expected that a project would specify its own
# phpunit dependency in its composer.json and that version of phpunit would be
# used instead.
RUN composer global require phpunit/phpunit:*

CMD ["phpunit"]
