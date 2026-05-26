# Tribunal Final Report

Date: 2026-05-26  
Mode: AUDIT MODE  
Workspace: `defendableos-tribunal-audit`

## Executive Holding

Severity remains HIGH for published, reproducible API proof.

This finding does **not** prove the product runtime API is broken.

This finding **does** prove that the shipped in-process `TestClient` API proof is not reproducible in the clean audit environment and therefore cannot support acceptance as published.

Live localhost HTTP succeeded for both affected modules under `uvicorn`.

## Environment Tape

- Python `3.13.7`
- `anyio==4.12.1`
- `fastapi==0.136.1`
- `httpx==0.28.1`
- `pydantic==2.12.5`
- `pytest==9.0.3`
- `starlette==1.0.0`
- `uvicorn==0.46.0`

Audited public commits:

- `swarm-doctor` `084849e20d491e616bf4c76149addb305abaae00`
- `conditioning-coach` `b384cb98c08ef83ee7aaa626920415b041d4c5bb`
- `owner-roster-registry` `88542d9947b73a4defbf301f319a5fcd0f062c6e`
- `permission-broker` `7229e21d77f45e0b1cd68a51870cf479af3a6cab`

## Findings Table

| ID | Severity | Scope | Finding | Treatment |
|---|---|---|---|---|
| F1 | HIGH | `owner-roster-registry` | Published FastAPI in-process proof hangs after `TestClient` creation on `client.get("/health")`; live `uvicorn` HTTP works | Hold `VERIFIED_AS_IMPLEMENTED`; classify `TEST_HARNESS_FAILURE`; module may be `VERIFIED_WITH_LIMITATIONS` only |
| F2 | HIGH | `permission-broker` | Published FastAPI in-process proof hangs after `TestClient` creation on `client.get("/health")`; live `uvicorn` HTTP works | Hold `VERIFIED_AS_IMPLEMENTED`; classify `TEST_HARNESS_FAILURE`; module may be `VERIFIED_WITH_LIMITATIONS` only |
| F3 | MEDIUM | Cross-module API proof lane | A trivial control FastAPI app also hangs in-process under the same installed stack, so the present evidence points to the local ASGI/TestClient proof path rather than confirmed runtime injury in either product module | Hold API integration promotion; keep runtime/API distinction explicit |
| F4 | MEDIUM | Audit/provenance boundary | Hashes prove local file integrity for receipts, exports, and audit artifacts, but do not prove human authorship, real-world identity, external SaaS restriction, on-chain ENS control, or independent provenance beyond the audited workspace state | Keep limitation statement attached to all readiness claims |

## F1/F2/F3/F4 Treatment

### F1

- Accepted
- Severity: HIGH
- Classification: `TEST_HARNESS_FAILURE`
- Product runtime API shown broken by this finding: no
- Published automated API proof acceptable: no

Evidence:

- `MODULE_OWNER_ROSTER_REGISTRY_REPORT.md`
- `owner-roster-registry/tests/test_cloud_api.py:11`
- `owner-roster-registry/registry/app.py:20`

### F2

- Accepted
- Severity: HIGH
- Classification: `TEST_HARNESS_FAILURE`
- Product runtime API shown broken by this finding: no
- Published automated API proof acceptable: no

Evidence:

- `MODULE_PERMISSION_BROKER_REPORT.md`
- `permission-broker/tests/test_api.py:15`
- `permission-broker/broker/app.py:22`

### F3

- Accepted
- Severity: MEDIUM
- Classification: supporting control
- Product runtime API shown broken by this finding: no
- Published automated API proof acceptable: no

Evidence:

- `timeout 20s python3 -u -c "from fastapi import FastAPI; from fastapi.testclient import TestClient; app=FastAPI(); app.add_api_route('/health', lambda: {'ok': True}, methods=['GET']); print('before TestClient'); client=TestClient(app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"` printed `before TestClient`, `after TestClient`, then timed out.
- `timeout 10s python3 -u -c ... httpx.ASGITransport ...` printed `before async client`, `before request`, then timed out.

### F4

- Accepted
- Severity: MEDIUM
- Classification: limitation statement
- Product runtime API shown broken by this finding: no
- Published automated API proof acceptable: not applicable

## Formal Module Verdicts

### swarm-doctor

Verdict: `VERIFIED_WITH_LIMITATIONS`

Reason:

- health math executed and selftests passed;
- continuity doctrine outcomes executed and matched expected receipt behavior;
- scope remains local/offline prototype only.

Key proof:

- selftest passed
- continuity outcomes and paging doctrine exercised
- implementation refs:
  - `swarm-doctor/cli/swarm_doctor.py:263`
  - `swarm-doctor/cli/swarm_doctor.py:365`

### conditioning-coach

Verdict: `VERIFIED_WITH_LIMITATIONS`

Reason:

- weighted readiness math executed and selftests passed;
- hard-flag override behavior executed;
- scope remains recommendation-only and explicitly not continuity/permission enforcement.

Key proof:

- selftest passed
- score and hard-flag override behavior executed
- implementation refs:
  - `conditioning-coach/cli/conditioning_coach.py:124`
  - `conditioning-coach/cli/conditioning_coach.py:194`

### owner-roster-registry

Verdict: `VERIFIED_WITH_LIMITATIONS`

Reason:

- receipt validation, rejection quarantine, owner-state separation, docs export, cloud export, and live localhost HTTP were executed successfully;
- published in-process API proof failed at HIGH severity, so this module may not receive `VERIFIED_AS_IMPLEMENTED`.

Key proof:

- valid and tampered receipts handled correctly
- continuity state separated from owner-approved state
- live `uvicorn` `/health` and `/api/v1/companies/acme-helpdesk/cloud-snapshot` returned `200`
- docs export and cloud export executed

### permission-broker

Verdict: `VERIFIED_WITH_LIMITATIONS`

Reason:

- local policy compilation, allow/deny routing, approval queue, local mock side effects, docs export, cloud export, and live localhost HTTP were executed successfully;
- published in-process API proof failed at HIGH severity, so this module may not receive `VERIFIED_AS_IMPLEMENTED`.

Key proof:

- forbidden backup action block independently verified through CLI and state inspection
- live `uvicorn` `/health` and `/api/v1/companies/acme-helpdesk/enforcement-summary` returned `200`
- API execution route remains proof-limited because shipped `TestClient` proof hangs

## Formal Cross-Module Verdict

Verdict: `VERIFIED_WITH_LIMITATIONS`

Reason:

- the four-module chain is materially demonstrated at the CLI/export/runtime-local level;
- the API proof lane for the two server modules is held;
- external SaaS control, live revocation, live paging, blockchain/ENS implementation, and autonomous external enforcement remain unproven and outside the executed proof.

## Fresh-Output Interoperation Evidence

Fresh chain executed from disposable audit copies:

1. Registry run-copy imported doctor and coach receipts, recorded owner decisions, then exported a fresh DefendableCloud snapshot:
   - path: fresh registry run-copy cloud snapshot export
   - snapshot hash: `4b87d7a116bb47ea5a97e58bd84a83f23a5928036c1443d7107b897cab38a458`
2. Broker clean run-copy imported that exact fresh file:
   - import accepted
   - `source_hash = 4b87d7a116bb47ea5a97e58bd84a83f23a5928036c1443d7107b897cab38a458`
3. Broker compiled policy from that imported fresh snapshot:
   - `source_registry_snapshot_hash = 4b87d7a116bb47ea5a97e58bd84a83f23a5928036c1443d7107b897cab38a458`
   - starter authority empty under `INJURED_RESERVE`
   - backup allowed actions restricted to the backup’s own approved play set

Result:

- fresh-output interoperation is supported at the CLI/export/import layer.

## Broker Side-Effect Proof

Independent verification on clean broker interop copy:

- allowed action:
  - `classify_ticket` -> `ALLOW_AND_EXECUTE_LOCAL_MOCK`
  - created one local mock record: `mock-06158d4b22`
- forbidden action:
  - `issue_refund` -> `DENY_ACTION_NOT_IN_PERMISSION_ENVELOPE`
  - no additional local mock record created
- approval path:
  - `request_refund_review` -> `QUEUE_FOR_HUMAN_APPROVAL`
  - no sensitive action executed

State inspection of the clean broker interop run-copy database showed:

- `mock_record_count = 1`
- enforcement receipts:
  - `classify_ticket / ALLOW_AND_EXECUTE_LOCAL_MOCK / executed=1`
  - `issue_refund / DENY_ACTION_NOT_IN_PERMISSION_ENVELOPE / executed=0`
  - `request_refund_review / QUEUE_FOR_HUMAN_APPROVAL / executed=0`

Conclusion:

- forbidden action block was independently verified through CLI and state inspection;
- the API execution route remains proof-limited.

## Hash/Authorship Limitation Statement

This audit confirms local receipt hashes, policy hashes, export hashes, snapshot hashes, and audit artifact hashes as integrity markers over the files actually examined.

This audit does **not** confirm:

- human authorship of the public commits;
- real-world legal identity behind any ENS-style identifier;
- independent provenance beyond the cloned repositories and generated local audit outputs;
- live control over external SaaS platforms, credentials, or agent bypass paths;
- on-chain ENS implementation;
- insurance, certification, or legal enforceability.

## Readiness

### Public Demo Readiness

Status: `READY_WITH_LIMITATIONS`

Reason:

- CLI flows, receipts, exports, live localhost HTTP, and inter-module handoff can be demonstrated;
- published automated API proof is not reproducible in this environment, so demo claims must not overstate that lane.

### DefendableCloud Readiness

Status: `HOLD`

Reason:

- hold API integration promotion until a repaired, fresh-environment reproducible API test path is independently rerun;
- live localhost HTTP works, but shipped automated API proof is not currently acceptable as published.

### DefendableDocs Readiness

Status: `READY_WITH_LIMITATIONS`

Reason:

- fresh registry docs export executed:
  - export hash `c39a374f4bcda8fd0f4b6bb3410fd5c1d5158618def213c98de69b1d07548175`
- fresh broker docs export executed:
  - export hash `6607be55c8c1c97fa19db01beb6a329e72512b6c49a55375f85ee37ffe9414f3`
- limitation remains the same prototype scope and held API proof lane.

## Repair Queue

No repair work is performed in this pass.

Queue for later repair analysis only:

1. Reproduce the in-process ASGI hang in a fully isolated, pinned environment.
2. Determine whether the failure is caused by dependency drift, Python 3.13 interaction, or another local harness incompatibility.
3. Re-run the published API proof on a fresh environment after repair analysis.
4. Only after that, reconsider API promotion or `VERIFIED_AS_IMPLEMENTED` status for the two affected modules.

## Audit Artifact Set

Primary reports:

- `TRIBUNAL_FINAL_REPORT_2026-05-26.md`
- `AUDIT_REPORT_2026-05-26.md`
- `MODULE_OWNER_ROSTER_REGISTRY_REPORT.md`
- `MODULE_PERMISSION_BROKER_REPORT.md`
- `EXECUTIVE_OWNER_REPORT.md`

Findings receipts:

- `findings/owner-roster-registry_api_test_harness_failure.json`
- `findings/permission-broker_api_test_harness_failure.json`
- `findings/cross-module_api_proof_hold.json`

Manifest and receipt hashes are recorded in:

- `AUDIT_MANIFEST_2026-05-26.json`
- `AUDIT_RECEIPT_2026-05-26.json`
