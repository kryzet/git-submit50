# When bash is invoked like this, it will behave as a POSIX-conformant
# command interpreter. However, this can only be expected to work on numerous
# Linux distributions and not on OS X (#1, #5) or other POSIX or SUS platforms
# (#2, #4).
#!/usr/bin/env sh

# Oddly enough, a reference to an unset variable does not cause the shell
# to exit. See the POSIX manpage for `set` or
# https://pubs.opengroup.org/onlinepubs/9699919799.2018edition/utilities/V3_chap02.html#set
# to learn more.
set -eu

# See Usage in the README. #6
branch="$1"

# submit50 expects to be invoked from within the directory where the files to
# be submitted are, so it is reasonable to simply make the same assumption.
# This is totally a valid area of improvement, though.
assignment_dir=$PWD

# This will be the ref used to update the submission contents to the latest
# snapshot.
ref=$(git symbolic-ref --short HEAD)

# Switch to the slug branch
if git rev-parse --verify --end-of-options $branch^{branch}; then
    git switch $branch
else
    git checkout --orphan $branch
fi