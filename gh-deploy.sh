#!/bin/sh
if [ -z "$1" ]
then
  echo "You need to enter a commit message"
  exit 1
fi

git add dist && git commit -m "$1"
git subtree push --prefix dist origin gh-pages