# DefendableOS Tribunal Audit

This repository contains an independent technical audit pass performed by Codex against builder-produced public prototype modules. It is not certification, production clearance, legal attestation, insurance coverage, or cryptographic proof of authorship. SHA-256 hashes in this repository establish content-integrity linkage only.

## Scope

Audited public prototype modules:

- `swarm-doctor` at commit `084849e20d491e616bf4c76149addb305abaae00`
- `conditioning-coach` at commit `b384cb98c08ef83ee7aaa626920415b041d4c5bb`
- `owner-roster-registry` at commit `88542d9947b73a4defbf301f319a5fcd0f062c6e`
- `permission-broker` at commit `7229e21d77f45e0b1cd68a51870cf479af3a6cab`

## Primary Artifacts

- `TRIBUNAL_FINAL_REPORT_2026-05-26.md`
- `AUDIT_REPORT_2026-05-26.md`
- `MODULE_OWNER_ROSTER_REGISTRY_REPORT.md`
- `MODULE_PERMISSION_BROKER_REPORT.md`
- `EXECUTIVE_OWNER_REPORT.md`
- `findings/`
- `evidence/`
- `harness/`
- `safety/`
- `AUDIT_MANIFEST_2026-05-26.json`
- `AUDIT_RECEIPT_2026-05-26.json`

## Status

- All four modules: `VERIFIED_WITH_LIMITATIONS`
- Cross-module verdict: `VERIFIED_WITH_LIMITATIONS`
- DefendableCloud readiness: `HOLD`
- DefendableDocs readiness: `READY_WITH_LIMITATIONS`
- Public demo readiness: `READY_WITH_LIMITATIONS`

## Re-Audit Status

Repaired public commits were independently re-audited under `reaudit/2026-05-26_tribunal_repair_v0.1/`.

- All four repaired modules: `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS`
- Cross-module repaired verdict: `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS`
- Live-HTTP replacement proof closed the prior API promotion hold sufficiently for `READY_WITH_LIMITATIONS`
- In-process `FastAPI TestClient` remains an environment-fragile unresolved limitation in the Codex re-audit environment
- DefendableCloud API promotion: `READY_WITH_LIMITATIONS`
- DefendableDocs readiness: `READY_WITH_LIMITATIONS`
- Public demo readiness: `READY_WITH_LIMITATIONS`
- Production deployment: `NOT CLEARED`
- External SaaS enforcement: `NOT CLEARED`

No production or external SaaS enforcement clearance is claimed.
