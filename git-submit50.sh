# When bash is invoked like this, it will provide a POSIX-conformant
# environment.
#!/usr/bin/env sh

# A reference to an unset variable (oddly enough) or a failure upon executing a
# command does not cause the shell to terminate script interpretation.
set -eu

branch="$1"
assignment_dir=$PWD
ref=$(git symbolic-ref --short HEAD)
if git rev-parse --verify --end-of-options $branch^{branch}; then
    git switch $branch
else
    git checkout --orphan $branch
fi