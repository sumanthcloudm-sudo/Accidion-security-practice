# AGENTS.md

Guidance for AI coding agents working in this repository.
Human engineers: this file is also your map of how we work.

## Project
AccIDion — a multi-tenant SaaS platform. Tenant isolation is the
non-negotiable property: no code path may read or write another
tenant's data without an explicit, tested authorization check.

## Language and stack
- Target runtime: Java 25, Spring Boot 4.1.x (pending D2 decision;
  do not assume until recorded in an ADR).
- Build tool: Maven unless an ADR says otherwise.
- IaC: OpenTofu. Applies run from CI only — never from a laptop.
- Container images: signed with cosign; deploys verify by digest.

## Repository layout
- `src/main/java` — application code, packaged by feature.
- `src/test/java` — unit and integration tests. Tenant-isolation
  tests live under `.../isolation/` and must run on every PR.
- `.github/workflows` — CI definitions. Job names here are the
  source of truth for required status checks.
- `infra/` — OpenTofu modules. No secrets in this tree.
- `docs/` — ADRs and design notes. Every architecture choice gets
  an ADR before code.

## Conventions
- Branch names: `<type>/<ticket>-<short-desc>` where type is
  feat, fix, chore, or docs. Example: `feat/ACC-12-health-endpoint`.
- Commits: imperative mood, one logical change each.
- Public APIs: no breaking changes without a deprecation cycle
  noted in the PR.
- Logging: structured JSON, never log secrets, tokens, or
  personally identifiable data. Redact before write.
- Errors: wrap with context, propagate typed exceptions, map to
  HTTP status in controllers only.

## Testing rules
- Every PR must include tests for new behavior.
- Tenant-isolation scenarios are mandatory for any data-access
  change: cross-tenant read, cross-tenant write, missing tenant
  context.
- Flaky tests are bugs. Quarantine is not allowed without a
  linked issue.

## Security
- No secrets in source. Use GitHub Actions secrets or 1Password
  references.
- Third-party actions pinned to full commit SHAs.
- `permissions` blocks on workflows: read-only by default.
- AGPL/BUSL dependencies require explicit sign-off before merge.

## Pull requests
- Fill out the PR template completely.
- Request review from CODEOWNERS for touched paths.
- Do not merge with failing required checks.

## When unsure
Ask in the PR rather than guessing. A wrong assumption about
tenant isolation or licensing costs more than one round of review.
