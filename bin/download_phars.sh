#!/bin/sh
mkdir -p ~/.phar
curl -o ~/.phar/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
curl -o ~/.phar/phpunit.phar https://phar.phpunit.de/phpunit.phar
