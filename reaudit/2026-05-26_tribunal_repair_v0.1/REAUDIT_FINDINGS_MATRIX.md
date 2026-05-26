# Re-Audit Findings Matrix

## Fresh Clone And Scope Verification

| Module | Baseline | Repaired target | Fresh cloned HEAD | Scope result |
|---|---|---|---|---|
| `swarm-doctor` | `084849e20d491e616bf4c76149addb305abaae00` | `2135cc4395cb8521c0f6d382fb522339143b4c3a` | `2135cc4395cb8521c0f6d382fb522339143b4c3a` | authorized README/RELEASE changes only |
| `conditioning-coach` | `b384cb98c08ef83ee7aaa626920415b041d4c5bb` | `4319be4ccfb67460df2982196339cb1ea4b4d095` | `4319be4ccfb67460df2982196339cb1ea4b4d095` | authorized README/RELEASE changes only |
| `owner-roster-registry` | `88542d9947b73a4defbf301f319a5fcd0f062c6e` | `f622ea98ab5871a0cd882a0e2bfd963529c8d4a6` | `f622ea98ab5871a0cd882a0e2bfd963529c8d4a6` | within authorized API-proof and integrity-language scope |
| `permission-broker` | `7229e21d77f45e0b1cd68a51870cf479af3a6cab` | `5c7ee6601d9975697b2ed81d0d2997cab1a7c37a` | `5c7ee6601d9975697b2ed81d0d2997cab1a7c37a` | within authorized API-proof and integrity-language scope |

No unauthorized functional expansion was found in diff scope.

## F1 To F4

| Finding | Original issue | Re-audit evidence | Formal result |
|---|---|---|---|
| F1 | `owner-roster-registry` shipped `TestClient` API proof hung in Codex environment | baseline still hangs; repaired live-HTTP pytest passes; repaired in-process pytest still times out; manual `uvicorn` HTTP succeeds; wrong-endpoint negative control fails with `404` | `PARTIALLY_CLOSED` |
| F2 | `permission-broker` shipped `TestClient` API proof hung in Codex environment | baseline still hangs; repaired live-HTTP pytest passes; repaired in-process pytest still times out; manual `uvicorn` HTTP succeeds; wrong-endpoint negative control fails with `404` | `PARTIALLY_CLOSED` |
| F3 | trivial FastAPI control app also hung under in-process `TestClient` path | original trivial-control hang still reproduced; new live-HTTP path avoids that failure mode and verifies API claims in this environment | `CLOSED` |
| F4 | hashes could be read as more than integrity linkage | aligned integrity-only language present in all four READMEs/RELEASEs and in repaired Registry/Broker exports | `CLOSED` |

## API Proof Classification

### Owner Roster Registry

- Baseline in-process proof: still hangs after `TestClient` construction on request execution.
- Repaired in-process proof: still timed out under `pytest` in this environment; no observed clean skip before timeout.
- Repaired authoritative proof: `tests/test_api_live_http.py` passed.
- Manual runtime proof: `GET /health` and `GET /api/v1/companies/acme-helpdesk/cloud-snapshot` returned `200`.
- Negative control: changing the endpoint path in a disposable audit-only copy produced a failing test with `HTTP Error 404`.

### Permission Broker

- Baseline in-process proof: still hangs after `TestClient` construction on request execution.
- Repaired in-process proof: still timed out under `pytest` in this environment; no observed clean skip before timeout.
- Repaired authoritative proof: `tests/test_api_live_http.py` passed.
- Manual runtime proof: `GET /health` and `GET /api/v1/companies/acme-helpdesk/enforcement-summary` returned `200`.
- Negative control: changing the endpoint path in a disposable audit-only copy produced a failing test with `HTTP Error 404`.

## Preserved Core Behavior

| Module | Preserved behavior result |
|---|---|
| `swarm-doctor` | `python3 cli/swarm_doctor.py --selftest examples/sheets` passed |
| `conditioning-coach` | `python3 cli/conditioning_coach.py --selftest .` passed |
| `owner-roster-registry` | non-API pytest set passed; recommendation, owner-approved state, continuity assignment, and coverage-state separation preserved |
| `permission-broker` | non-API pytest set passed; one allowed action executed, refund remained denied, human review queued, refund side effects remained zero |

## F4 Language Verification

Verified in:

- `swarm-doctor` README and RELEASE
- `conditioning-coach` README and RELEASE
- `owner-roster-registry` README, RELEASE, regenerated DefendableDocs exports, and export manifest `hash_integrity_note`
- `permission-broker` README, RELEASE, regenerated DefendableCloud and DefendableDocs exports, and export manifests `hash_integrity_note`

No contrary wording was found in the repaired scope claiming authorship proof, immutable proof, signed proof, owner-authenticated proof, certification, or external platform enforcement solely from hashes.

## Open Repair Findings

1. `owner-roster-registry`: repaired in-process pytest hardening did not cleanly skip or pass in this Codex environment; it still timed out.
2. `permission-broker`: repaired in-process pytest hardening did not cleanly skip or pass in this Codex environment; it still timed out.

## Owner-Directed Future Hardening / External-Integration Gates

- Swarm-Doctor runtime/schema enforcement
- Permission Broker replay/idempotency control
- Permission Broker payload-content restricted-assertion guard
