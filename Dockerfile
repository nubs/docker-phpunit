FROM nubs/composer-build

MAINTAINER Spencer Rinehart <anubis@overthemonkey.com>

USER root

RUN pacman --sync --refresh --sysupgrade --ignore filesystem --noconfirm --noprogressbar --quiet && pacman --sync --noconfirm --noprogressbar --quiet xdebug

ADD phpunit-dependencies.ini /etc/php/conf.d/phpunit-dependencies.ini

USER build

RUN composer global require phpunit/phpunit:*

CMD ["phpunit"]
