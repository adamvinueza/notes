#!/bin/zsh
if [[ -n $(git status -s) ]]
then
    echo You have uncommitted changes!
else
    curr=`git rev-parse --abbrev-ref HEAD -- | head -1`
    git checkout master && git pull
    git checkout $curr
fi
