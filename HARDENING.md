<!-- markdownlint-disable -->

# Hardening Report: addnab--docker-run-action/v2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **addnab--docker-run-action/v2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file .github/workflows/tests.yml references actions using mutable tag-based refs instead of immutable 40-character SHA digests. Failing references: `actions/checkout@v2` (used 3 times) and `actions/github-script@v3` (used 2 times). These can be silently updated by the upstream repository, enabling supply-chain attacks.

Locations:

- `.github/workflows/tests.yml:13`
- `.github/workflows/tests.yml:20`
- `.github/workflows/tests.yml:28`
- `.github/workflows/tests.yml:38`
- `.github/workflows/tests.yml:53`

### missing-permissions (severity: medium)

The workflow file .github/workflows/tests.yml has no top-level `permissions:` key and none of its three jobs (smoke-test, volume-mount-test, container-network-test) define job-level `permissions:`. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be overly broad (write access to contents, pull-requests, etc.).

Locations:

- `.github/workflows/tests.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed .github/workflows/tests.yml: (1) Pinned all 5 mutable action references to full 40-char SHA digests — actions/checkout@v2 → @0717577d45739eb3c851188b29f50ed6c0b2194e (3 occurrences) and actions/github-script@v3 → @ffc2c79a5b2490bd33e0a41c1de74b877714d736 (2 occurrences), preserving the original tag in a comment for readability. (2) Added a top-level `permissions: contents: read` block to restrict the GITHUB_TOKEN to the minimum needed (read-only checkout access).

