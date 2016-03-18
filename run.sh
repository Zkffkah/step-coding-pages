#!/bin/sh

# use repo option or guess from git info
if [ -n "$WERCKER_CODING_PAGES_REPO" ]
then
  repo="$WERCKER_CODING_PAGES_REPO"
elif [ 'github.com' == "$WERCKER_GIT_DOMAIN" ]
then
  repo="$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
else
  fail "missing option \"repo\", aborting"
fi

info "using github repo \"$repo\""

# remote path
remote="git@git.coding.net:$repo.git"

# if directory provided, cd to it
if [ -d "$WERCKER_CODING_PAGES_BASEDIR" ]
then
  cd $WERCKER_CODING_PAGES_BASEDIR
fi

# remove existing commit history
rm -rf .git

# generate cname file
if [ -n $WERCKER_CODING_PAGES_DOMAIN ]
then
  echo $WERCKER_CODING_PAGES_DOMAIN > CNAME
fi


# setup branch
branch="coding-pages"
# if [[ "$repo" =~ $WERCKER_GIT_OWNER\/$  \.github\.(io|com)$ ]]; then
# 	branch="master"
# fi


# init repository
git init

git config user.email "pleasemailus@wercker.com"
git config user.name "werckerbot"

git add .
git commit -m "deploy from $WERCKER_STARTED_BY"
result="$(git push -f $remote master:$branch)"

if [[ $? -ne 0 ]]
then
  warning "$result"
  fail "failed pushing to github pages"
else
  success "pushed to coding pages"
fi

