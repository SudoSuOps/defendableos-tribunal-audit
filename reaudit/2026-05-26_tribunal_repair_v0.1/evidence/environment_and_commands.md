# Environment And Commands

## Environment

- Timestamp: `2026-05-26T12:32:32-04:00`
- Python: `Python 3.13.7`
- Dependency subset:
  - `anyio==4.12.1`
  - `fastapi==0.136.1`
  - `httpx==0.28.1`
  - `pydantic==2.12.5`
  - `pytest==9.0.3`
  - `starlette==1.0.0`
  - `uvicorn==0.46.0`

## Fresh Clone Proof

```bash
git clone https://github.com/SudoSuOps/swarm-doctor \
  reaudit/2026-05-26_tribunal_repair_v0.1/clones/swarm-doctor
git clone https://github.com/SudoSuOps/conditioning-coach \
  reaudit/2026-05-26_tribunal_repair_v0.1/clones/conditioning-coach
git clone https://github.com/SudoSuOps/owner-roster-registry \
  reaudit/2026-05-26_tribunal_repair_v0.1/clones/owner-roster-registry
git clone https://github.com/SudoSuOps/permission-broker \
  reaudit/2026-05-26_tribunal_repair_v0.1/clones/permission-broker
git rev-parse HEAD
```

## Scope Verification Commands

```bash
git diff --name-status 084849e20d491e616bf4c76149addb305abaae00..2135cc4395cb8521c0f6d382fb522339143b4c3a
git diff --name-status b384cb98c08ef83ee7aaa626920415b041d4c5bb..4319be4ccfb67460df2982196339cb1ea4b4d095
git diff --name-status 88542d9947b73a4defbf301f319a5fcd0f062c6e..f622ea98ab5871a0cd882a0e2bfd963529c8d4a6
git diff --name-status 7229e21d77f45e0b1cd68a51870cf479af3a6cab..5c7ee6601d9975697b2ed81d0d2997cab1a7c37a
```

## Baseline Reproduction Commands

```bash
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from registry import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code)"
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from broker import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code)"
timeout 20s python3 -u -c "from fastapi import FastAPI; from fastapi.testclient import TestClient; app=FastAPI(); @app.get('/health')\nasync def h(): return {'status':'ok'}\nprint('before TestClient'); client=TestClient(app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code)"
```

Observed baseline stdout before timeout for all three:

```text
before TestClient
after TestClient
```

Observed baseline result:

- exit code `124` from `timeout`
- hang point remained request execution

## Repaired API Proof Commands

```bash
timeout 40s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q -vv -s tests/test_cloud_api.py
timeout 40s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q -vv -s tests/test_api.py
timeout 60s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q -vv -s tests/test_api_live_http.py
```

Observed repaired in-process result in this Codex environment:

- `owner-roster-registry/tests/test_cloud_api.py`: timed out after collection/start of test execution
- `permission-broker/tests/test_api.py`: timed out after collection/start of test execution
- no clean skip was observed before timeout

Observed repaired live-HTTP result:

- `owner-roster-registry/tests/test_api_live_http.py`: `PASSED`
- `permission-broker/tests/test_api_live_http.py`: `PASSED`

## Preserved Behavior Commands

```bash
python3 cli/swarm_doctor.py --selftest examples/sheets
python3 cli/conditioning_coach.py --selftest .
timeout 60s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q \
  tests/test_receipt_import.py tests/test_status_engine.py tests/test_owner_decision.py \
  tests/test_docs_export.py tests/test_hash_rejection.py
timeout 60s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q \
  tests/test_backup_allowed_plays.py tests/test_backup_sensitive_action_denied.py \
  tests/test_human_approval_queue.py tests/test_injured_starter_denied.py \
  tests/test_policy_compiler.py tests/test_snapshot_import.py \
  tests/test_enforcement_receipts.py tests/test_exports.py
```

## Manual Live-Server Runtime Commands

Manual live-server checks were run by starting `uvicorn` with the repaired app module and calling:

```text
GET /health
GET /api/v1/companies/acme-helpdesk/cloud-snapshot
GET /api/v1/companies/acme-helpdesk/enforcement-summary
```

Observed results:

- Registry: `200` and clean shutdown after explicit terminate
- Broker: `200` and clean shutdown after explicit terminate

## Negative Control Commands

Disposable audit-only copies were created in a temporary directory and their live-HTTP endpoint paths were intentionally changed:

```bash
timeout 60s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -q -vv -s tests/test_api_live_http.py
```

Observed result:

- Registry negative control: `FAILED` with `HTTP Error 404`
- Broker negative control: `FAILED` with `HTTP Error 404`
