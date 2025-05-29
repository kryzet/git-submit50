# When bash is invoked like this, it will provide a POSIX-conformant
# environment.
#!/usr/bin/env sh

# A reference to an unset variable (oddly enough) or a failure upon executing a
# command does not cause the shell to terminate script interpretation.
set -eu