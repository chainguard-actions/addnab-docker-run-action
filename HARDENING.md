<!-- markdownlint-disable -->

# Hardening Report: addnab--docker-run-action/v1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **addnab--docker-run-action/v1** was hardened automatically. 0 finding(s) were identified and resolved across 1 iteration(s).

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection

**Notes:**

Fixed all unquoted $INPUT_* variable expansions in entrypoint.sh:
- Line 3: Quoted $INPUT_USERNAME in [ ! -z ] test
- Line 4: Quoted $INPUT_PASSWORD, $INPUT_REGISTRY, $INPUT_USERNAME in docker login command
- Line 9: Tokenized $INPUT_OPTIONS into a bash array via xargs (with guard + NUL-delimited read loop) since it is a list input; double-quoted $INPUT_SHELL and $INPUT_IMAGE as single values; split --entrypoint=$INPUT_SHELL into two separate arguments --entrypoint "$INPUT_SHELL"; replaced backtick command substitution with $(...)

