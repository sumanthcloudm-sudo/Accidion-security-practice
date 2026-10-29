# RULES.md

Non-negotiable engineering rules for AccIDion.
These apply to every contributor and every AI agent.

## 1. Tenant isolation
- No code path may read or write another tenant’s data without an explicit, tested authorization check.
- Every data-access change must include tenant-isolation tests (cross-tenant read, cross-tenant write, missing tenant context).
- Isolation tests run on every pull request and are required status checks.

## 2. Secrets and credentials
- Never commit secrets, tokens, keys, or `.env` files.
- Use GitHub Actions secrets or 1Password references.
- Secret scanning + push protection must stay enabled.

## 3. Infrastructure
- OpenTofu applies run only from CI.
- No infrastructure changes from a laptop.
- Image signing (cosign) and digest verification required before any deploy.

## 4. Supply chain
- Third-party GitHub Actions must be pinned to full commit SHAs.
- Workflow `permissions` blocks default to read-only.
- AGPL or BUSL dependencies require explicit written sign-off before merge.

## 5. Code and reviews
- One logical change per pull request.
- Fill the PR template completely.
- CODEOWNERS review is mandatory for protected paths.
- Do not merge with failing required checks.
- Public APIs: no breaking changes without a deprecation cycle noted in the PR.

## 6. Testing
- Every PR must include tests for new behaviour.
- Flaky tests are bugs. Quarantine requires a linked issue.
- Build + unit tests must pass on every PR.

## 7. Logging and errors
- Structured JSON logs only.
- Never log secrets, tokens, or personally identifiable data.
- Wrap errors with context; map to HTTP status only in controllers.

## 8. Architecture decisions
- Record significant choices as ADRs in `docs/adr/` before implementation.
- Stack and runtime decisions (D1, D2) must be recorded before finalising repo layout or IaC modules.

## 9. Out of scope without human approval
- Production deployments
- IAM policy changes
- Secret rotation
- Deleting or rewriting migration files

## 10. When unsure
Ask in the pull request. A wrong assumption about tenant isolation or licensing costs more than one extra review cycle.
