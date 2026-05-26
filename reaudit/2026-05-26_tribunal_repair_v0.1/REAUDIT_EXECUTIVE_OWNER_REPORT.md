# CODEX INDEPENDENT RE-AUDIT — REPAIRED COMMITS v0.1

This re-audit is an independent technical verification of the authorized repair scope. It is not certification, production clearance, insurance coverage, external SaaS enforcement approval, or proof of authorship.

## Executive Result

Claude's public repair sprint materially improved the published tape.

- Fresh repaired heads matched the owner-specified targets for all four modules.
- `swarm-doctor` and `conditioning-coach` stayed within the authorized non-functional integrity-language scope.
- `owner-roster-registry` and `permission-broker` added a reproducible live-HTTP API release-proof path and preserved previously verified limited business behavior.
- No unauthorized doctrine expansion, authority expansion, replay/idempotency feature, payload-content policy feature, or external connector addition was found.

The decisive remaining limitation is narrower than the original finding but not fully gone:

- In this Codex clean environment, the repaired in-process `FastAPI TestClient` pytest paths still do not exit before timeout.
- The newly added live-HTTP proof path does run reproducibly and fails correctly under an intentional wrong-endpoint negative control.
- The repos now publish a usable authoritative API proof path, but the attempted "skip-not-hang" hardening of the in-process path was not fully successful here.

## Formal Verdicts

### Finding Closure

| Finding | Re-audit result | Tribunal treatment |
|---|---|---|
| F1 `owner-roster-registry` published in-process API proof hang | `PARTIALLY_CLOSED` | live-HTTP replacement proof is reproducible; in-process pytest path still times out here |
| F2 `permission-broker` published in-process API proof hang | `PARTIALLY_CLOSED` | live-HTTP replacement proof is reproducible; in-process pytest path still times out here |
| F3 ASGI/TestClient environment-path failure classification | `CLOSED` | `CLOSED_BY_REPRODUCIBLE_REPLACEMENT_PROOF` |
| F4 SHA-256 integrity-language overclaim risk | `CLOSED` | aligned in README, RELEASE, and repaired exports |

### Module Verdicts

| Module | Re-audit verdict | Basis |
|---|---|---|
| `swarm-doctor` | `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS` | repaired scope limited to README/RELEASE language; selftest still passes |
| `conditioning-coach` | `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS` | repaired scope limited to README/RELEASE language; selftest still passes |
| `owner-roster-registry` | `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS` | live-HTTP API proof added and reproducible; doctrine preserved; in-process pytest hardening still not clean here |
| `permission-broker` | `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS` | live-HTTP API proof added and reproducible; enforcement behavior preserved; in-process pytest hardening still not clean here |

### Readiness

| Category | Re-audit recommendation |
|---|---|
| Public demo | `READY_WITH_LIMITATIONS` |
| DefendableDocs | `READY_WITH_LIMITATIONS` |
| DefendableCloud API promotion | `READY_WITH_LIMITATIONS` |

`READY_WITH_LIMITATIONS` for DefendableCloud API promotion is based on the new live-HTTP release-proof path, not on the repaired in-process `TestClient` path.

## Owner Answer

The repaired runtime API was not shown broken in this re-audit.

- Live localhost `uvicorn` HTTP succeeded for both repaired API modules.
- The shipped `TestClient`-based in-process tests remain non-authoritative in this Codex environment because they still timed out.
- The new live-HTTP proof is the accepted replacement proof path because it is reproducible here and fails red under an intentional wrong-endpoint audit control.

## Scope Control

No unauthorized functional expansion was found.

- `swarm-doctor`: README and RELEASE only.
- `conditioning-coach`: README and RELEASE only.
- `owner-roster-registry`: API-proof repair files, export integrity-language addition, README, RELEASE, and generated export artifacts only.
- `permission-broker`: API-proof repair files, export integrity-language addition, README, RELEASE, and generated export artifacts only.

## Open Limitation After Repair

The remaining open issue is not a route/runtime break finding.

- The repaired in-process pytest path still hangs in this Codex environment for both API modules.
- That means the "skip-not-hang" hardening claim was not fully reproduced here.
- Because the live-HTTP proof is now present and reproducible, this remaining issue is a documentation and proof-path limitation rather than a reversion to the original runtime-failure classification.

## Future Hardening

These are not charged as repair-sprint failures:

- Swarm-Doctor runtime/schema enforcement
- Permission Broker replay/idempotency control
- Permission Broker payload-content restricted-assertion guard

## Evidence Index

- [REAUDIT_FINDINGS_MATRIX.md](REAUDIT_FINDINGS_MATRIX.md)
- [REAUDIT_CROSS_MODULE_REPORT.md](REAUDIT_CROSS_MODULE_REPORT.md)
- [environment_and_commands.md](evidence/environment_and_commands.md)
- [scope_verification.json](evidence/scope_verification.json)
- [runtime_reproductions.json](evidence/runtime_reproductions.json)
- [cross_module_state.json](evidence/cross_module_state.json)
