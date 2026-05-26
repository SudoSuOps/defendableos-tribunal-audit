# DefendableOS Tribunal Audit

Date: 2026-05-26  
Mode: AUDIT MODE  
Workspace: `defendableos-tribunal-audit`

## Audited Commits

- `swarm-doctor` @ `084849e20d491e616bf4c76149addb305abaae00`
- `conditioning-coach` @ `b384cb98c08ef83ee7aaa626920415b041d4c5bb`
- `owner-roster-registry` @ `88542d9947b73a4defbf301f319a5fcd0f062c6e`
- `permission-broker` @ `7229e21d77f45e0b1cd68a51870cf479af3a6cab`

No product repositories were patched. No dependency files in product repositories were changed.

## Cross-Module Verdict

The published prototype still proves several narrow local duties:

- `swarm-doctor`: health math, continuity receipt generation, continuity doctrine outcomes.
- `conditioning-coach`: weighted readiness math, hard-flag override routing, hashed recommendation receipts.
- `owner-roster-registry`: receipt validation, hash verification, rejection quarantine, owner-status separation.
- `permission-broker`: broker-routed local mock enforcement from owner-approved registry evidence.

But a HIGH release-proof failure remains:

- the published FastAPI API proof for `owner-roster-registry` and `permission-broker` does not execute via `TestClient` in this clean audit environment.

Actual scope after diagnostic pass:

- live `uvicorn` HTTP works for both modules;
- in-process request execution hangs for both modules, including a trivial control FastAPI app under the same installed stack;
- therefore the current evidence supports `TEST_HARNESS_FAILURE` for both affected modules, not `API_RUNTIME_FAILURE`.

DefendableCloud-style API readiness must be held until the API proof is re-established in a repaired analysis environment.

## Shared Environment Evidence

- Python: `3.13.7`
- Installed subset:
  - `anyio==4.12.1`
  - `fastapi==0.136.1`
  - `httpx==0.28.1`
  - `pydantic==2.12.5`
  - `pytest==9.0.3`
  - `starlette==1.0.0`
  - `uvicorn==0.46.0`

Control evidence outside product repos:

- Trivial FastAPI app with `TestClient`:
  - command printed `before TestClient`
  - command printed `after TestClient`
  - hung on `client.get('/health')`
  - timed out after 20 seconds
- Trivial FastAPI app with `httpx.ASGITransport`:
  - command printed `before async client`
  - command printed `before request`
  - hung on in-process request execution
  - timed out after 10 seconds

This shifts suspicion away from product endpoint logic and toward the in-process ASGI test stack in this environment.

## Module Classifications

- `owner-roster-registry`: `TEST_HARNESS_FAILURE`
- `permission-broker`: `TEST_HARNESS_FAILURE`

The stricter `DEPENDENCY_COMPATIBILITY_FAILURE` label is not claimed because no alternate pinned environment was installed or proven in this pass.

## Claim Impact

### owner-roster-registry

- CLI proof remains valid: yes
- local export proof remains valid: yes
- API proof is invalidated in this audit environment: yes
- DefendableCloud integration readiness must be held: yes

### permission-broker

- CLI enforcement proof remains valid: yes
- local export proof remains valid: yes
- API proof is invalidated in this audit environment: yes
- DefendableCloud / API transition readiness must be held: yes
- CLI enforcement proof remains independently supported while API execution proof is held: yes

## Core Duty Proof Still Supported

### Math

- `swarm-doctor` scoring and findings logic: `swarm-doctor/cli/swarm_doctor.py:263`
- `conditioning-coach` transparent metric and score computation: `conditioning-coach/cli/conditioning_coach.py:124`
- `conditioning-coach` hard-flag override logic: `conditioning-coach/cli/conditioning_coach.py:162`

Runtime evidence:

- `python3 cli/swarm_doctor.py --selftest examples/sheets` -> `SELFTEST: PASS`
- `python3 cli/conditioning_coach.py --selftest .` -> `SELFTEST: PASS`

### Receipt Verification

- registry import order and rejection logic: `owner-roster-registry/registry/receipt_importer.py:36`
- independent receipt hash verification: `owner-roster-registry/registry/hash_verifier.py:1`

Runtime evidence:

- valid conditioning receipt accepted
- tampered receipt rejected as `REJECTED_HASH_INVALID`

### Continuity Doctrine and Owner Separation

- continuity mapping and starter/backup separation: `owner-roster-registry/registry/status_engine.py:24`
- owner approval only through owner decision path: `owner-roster-registry/registry/owner_decisions.py:17`

Runtime evidence:

- continuity receipt imported as `BACKUP_RESTRICTED_DUTY`
- starter remains a personnel case; backup carries continuity assignment; position group carries coverage state

### Broker-Routed Permission Enforcement

- policy compilation from verified owner-approved snapshot: `permission-broker/broker/policy_compiler.py:28`
- deterministic decision engine: `permission-broker/broker/policy_engine.py:15`
- atomic evaluate-and-execute gateway: `permission-broker/broker/enforcement_gateway.py:77`

Runtime evidence:

- backup `classify_ticket` allowed and executed locally
- backup `issue_refund` denied
- sensitive action review request queued for human approval

## Reports

- Module detail: `MODULE_OWNER_ROSTER_REGISTRY_REPORT.md`
- Module detail: `MODULE_PERMISSION_BROKER_REPORT.md`
- Owner summary: `EXECUTIVE_OWNER_REPORT.md`
- Findings receipts:
  - `findings/owner-roster-registry_api_test_harness_failure.json`
  - `findings/permission-broker_api_test_harness_failure.json`
  - `findings/cross-module_api_proof_hold.json`
