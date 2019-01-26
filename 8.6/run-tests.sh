#!/bin/bash
set -e

red=$'\e[1;31m'
grn=$'\e[1;32m'
end=$'\e[0m'
__error=0

printf "PATH: %s\\n" "${PATH}"

if [ -x "$(command -v php)" ]; then
  php -v | grep built
else
  printf "%sPhp missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v apache2)" ]; then
  apache2 -v | grep version
  a2query -s 000-default
else
  printf "%sApache missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v composer)" ]; then
  composer --version | grep version
else
  printf "%Composer missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v mysql)" ]; then
  mysql -V
else
  printf "%sMysql client missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v robo)" ]; then
  robo -V
else
  printf "%srobo missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v node)" ]; then
  printf "Node "
  node --version
else
  printf "%node missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v yarn)" ]; then
  yarn versions | grep 'versions'
else
  printf "%syarn missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v eslint)" ]; then
  printf "Eslint "
  eslint --version
else
  printf "%eslint missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v stylelint)" ]; then
  printf "Stylelint "
  stylelint --version
else
  printf "%stylelint missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v sass-lint)" ]; then
  printf "Sass-lint "
  sass-lint --version
else
  printf "%sass-lint missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v phpcs)" ]; then
  phpcs -i
else
  printf "%phpcs missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v phpqa)" ]; then
  phpqa tools
else
  printf "%sphpqa missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v shellcheck)" ]; then
  printf "Shellcheck "
  shellcheck --version | grep 'version'
else
  printf "%shellcheck missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v jq)" ]; then
  jq --version
else
  printf "%jq missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ -x "$(command -v sudo)" ]; then
  sudo --version | grep 'Sudo version'
else
  printf "%sudo missing!%s\\n" "${red}" "${end}"
  __error=1
fi

if [ $__error = 1 ]; then
  printf "\\n%s[ERROR] Tests failed!%s\\n\\n" "${red}" "${end}"
  exit 1
fi

exit 0