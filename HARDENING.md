<!-- markdownlint-disable -->

# Hardening Report: addnab--docker-run-action/v3

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **addnab--docker-run-action/v3** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file .github/workflows/tests.yml references actions by mutable tag refs instead of full 40-character commit SHAs. Unpinned refs are vulnerable to supply-chain attacks if the upstream tag is moved or the repository is compromised. Failing references: actions/checkout@v2 (lines 13, 30, 61), actions/github-script@v3 (lines 22, 42). All should be pinned to their full SHA, e.g. actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v2.

Locations:

- `.github/workflows/tests.yml:13`
- `.github/workflows/tests.yml:22`
- `.github/workflows/tests.yml:30`
- `.github/workflows/tests.yml:42`
- `.github/workflows/tests.yml:61`

### missing-permissions (severity: medium)

The workflow file .github/workflows/tests.yml has no top-level `permissions:` key, and none of its three jobs (smoke-test, volume-mount-test, container-network-test) define job-level `permissions:` blocks. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be overly broad (write access to contents, pull-requests, etc.). A minimal permissions block such as `permissions: read-all` or specific scopes should be added.

Locations:

- `.github/workflows/tests.yml:1`

### script-injection (severity: high)

Rule (a) violation: The container-network-test job passes a `${{ job.services.postgres.ports[5432] }}` expression directly inside a shell command string (the `run:` with-input value at line 67, which is executed as a shell command inside the Docker container). GitHub Actions interpolates this expression via YAML template substitution before the shell ever sees it, allowing an attacker who can influence the job context to inject shell metacharacters. The offending line is: `pg_isready -d test -U test -h postgres -p ${{ job.services.postgres.ports[5432] }}`. The value should be passed via an environment variable and double-quoted in the shell command instead.

Locations:

- `.github/workflows/tests.yml:67`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions, script-injection

**Notes:**

Fixed all three findings in .github/workflows/tests.yml: (1) Pinned actions/checkout@v2 to SHA 0717577d45739eb3c851188b29f50ed6c0b2194e and actions/github-script@v3 to SHA ffc2c79a5b2490bd33e0a41c1de74b877714d736 at all 5 locations. (2) Added top-level `permissions: {}` block to restrict default token permissions. (3) Moved the `${{ job.services.postgres.ports[5432] }}` expression from the shell run string into the step's `env:` block as POSTGRES_PORT, and referenced it as "$POSTGRES_PORT" in the shell command to prevent script injection.

