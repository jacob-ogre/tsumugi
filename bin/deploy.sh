#!/usr/bin/env bash

set -e

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
	echo "Not deploying pull requests."
	exit
fi

if [[ "master" != "$TRAVIS_BRANCH" ]]; then
	echo "Not on the 'master' branch."
	exit
fi

rm -rf .git
rm -r .gitignore

echo ".csscomb.json
.editorconfig
.jscsrc
.jshintignore
.travis.yml
Gemfile
Gemfile.lock
gulpfile.js
LICENSE
package.json
sample.html
screenshot_286.png
screenshot_572.png
/bin/
/css/
/layouts/
/node_modules/
/release/
/sass/
/screenshots/
/sketch/
/symbols-for-sketch-master/
*.sh
*.md" > .gitignore

git init
git config user.name "Travis CI"
git config user.email "youthkee@gmail.com"
git add .
git commit --quiet -m "Deploy from travis"
git clean -fdx
git rm -fr .gitignore
git commit --quiet -m "Deploy from travis"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:release > /dev/null 2>&1