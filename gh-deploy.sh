#!/bin/sh

if [ -z "$1" ]
then
  echo "You need to enter a commit message"
  exit 1
fi

npx gulp dist --codelabs-dir=codelabs

rm -rf .firebase
cp -r dist/codelabs dist/codelabs_tmp
rm -r dist/codelabs
cp -r dist/codelabs_tmp dist/codelabs
rm -r dist/codelabs_tmp


git add -A && git commit -m "$1"
npm version major
git push
# git subtree push --prefix dist origin gh-pages

firebase deploy