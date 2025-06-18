# When bash is invoked like this, it will provide a POSIX-conformant
# environment. Suggestions for making the script more portable are welcome.
#!/usr/bin/env sh

# A failure upon executing a command or (oddly enough) a reference to an unset
# variable does not cause the shell to terminate script interpretation.
set -eu

# First argument passed to the script is the CS50 slug, which is in fact a git
# branch
branch="$1"

# submit50 expects to be invoked from within the directory where the files to
# be submitted are, so it is reasonable to simply make the same assumption.
# This may be a supporting detail for an argument to write this utility in a
# language that's not shell, so that files can be found in a more flexible
# way :)
assignment_dir=$PWD

# Determine the current branch. This will be the ref used to update the
# submission contents to the latest snapshot.
ref=$(git symbolic-ref --short HEAD)

# Switch to the slug branch
if git rev-parse --verify --end-of-options $branch^{branch}; then
    git switch $branch
else
    git checkout --orphan $branch
fi