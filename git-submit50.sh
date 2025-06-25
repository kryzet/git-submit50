#!/usr/bin/env sh
# ^ When bash is invoked like this, it will behave as a POSIX-conformant
# command interpreter. However, this can only be expected to work on numerous
# Linux distributions and not on OS X (#1, #5) or other POSIX or SUS platforms
# (#2, #4).

# Oddly enough, a reference to an unset variable does not cause the shell
# to exit. See the POSIX manpage for `set` (available online at
# https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/utilities/V3_chap02.html#set)
# to learn more.
set -eu

# See Usage in the README. #6
branch="$1"

# Checkouts can only be done within a work tree.
git rev-parse --is-inside-work-tree

# submit50 expects to be invoked from within the directory where the files to
# be submitted are, so it is reasonable to simply make the same assumption.
# This is a valid area of improvement, though.
assignment_dir=$PWD

# This will be the ref used to update the submission contents to the latest
# snapshot.
ref=$(git symbolic-ref --short HEAD)

# Switch to the slug branch
# shellcheck disable=SC1083
if git rev-parse --verify --end-of-options "$branch"^{branch}; then
    git checkout "$branch"
else
    git checkout --orphan "$branch"
    cd "$(git rev-parse --show-toplevel)"
    rm -r ./*
fi

git checkout "$ref" -- "$assignment_dir"/*

git commit -m "automated submission by git-submit50"
# submit50 expects user.name to be the GitHub username, and therefore the name
# of the target repository, to which the changes should be pushed.
# A valid area of improvement.
username=$(git config user.name)
# TODO: this is meant to check if the push fails due to missing ssh key
if git push "git@github.com:me50/$username.git"; then
    git push "https://github.com/me50/$username"
fi

git checkout "$ref"