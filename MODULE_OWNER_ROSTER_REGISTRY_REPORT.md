# Owner Roster Registry Diagnostic Report

Module: `owner-roster-registry`  
Commit: `88542d9947b73a4defbf301f319a5fcd0f062c6e`  
Classification: `TEST_HARNESS_FAILURE`

## A. Environment Evidence

- Python: `3.13.7`
- Dependency subset:
  - `anyio==4.12.1`
  - `fastapi==0.136.1`
  - `httpx==0.28.1`
  - `pydantic==2.12.5`
  - `pytest==9.0.3`
  - `starlette==1.0.0`
  - `uvicorn==0.46.0`

Exact hanging command:

```bash
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from registry import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
```

Timeout used: `20s`

Stdout/stderr before timeout:

```text
before TestClient
after TestClient
```

## B. TestClient Reproduction

Observed sequence:

1. import app: success
2. print before `TestClient`: success
3. construct `TestClient`: success
4. print after `TestClient`: success
5. call `client.get("/health")`: hangs
6. print after response: never reached

Hang point: request execution, not client construction.

Relevant API entrypoint:

- `owner-roster-registry/registry/app.py:20`

## C. Pytest Reproduction

Command:

```bash
timeout 20s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -vv -s --setup-show owner-roster-registry/tests/test_cloud_api.py::test_cloud_snapshot_endpoint
```

Output before timeout:

```text
============================= test session starts ==============================
platform linux -- Python 3.13.7, pytest-9.0.3, pluggy-1.6.0 -- /usr/bin/python3
cachedir: .pytest_cache
rootdir: defendableos-tribunal-audit
collecting ... collected 1 item

owner-roster-registry/tests/test_cloud_api.py::test_cloud_snapshot_endpoint
SETUP    S tmp_path_factory
        SETUP    F tmp_path (fixtures used: tmp_path_factory)
        SETUP    F cfg (fixtures used: tmp_path)
        SETUP    F conn (fixtures used: cfg)
        SETUP    F monkeypatch
        owner-roster-registry/tests/test_cloud_api.py::test_cloud_snapshot_endpoint (fixtures used: cfg, conn, monkeypatch, request, tmp_path, tmp_path_factory)
```

Conclusion:

- collection: completed
- fixture setup: completed
- client construction vs request: pytest output alone does not distinguish
- minimal reproduction outside pytest proves the actual stall occurs on `client.get("/health")`

Referenced failing test:

- `owner-roster-registry/tests/test_cloud_api.py:11`

## D. Live Server Comparison

Disposable audit run-copy used:

- temporary owner-roster-registry run-copy

Preparation:

- `python3 cli/registry_cli.py init`
- `python3 cli/registry_cli.py load-roster examples/support_position_group.yaml`
- `python3 cli/registry_cli.py import-receipt --file examples/import_receipts/cc_support01_refer.json`
- `python3 cli/registry_cli.py import-receipt --file examples/import_receipts/sd_support01_backup.json`

Startup command:

```bash
python3 -m uvicorn registry.app:app --host 127.0.0.1 --port 18079
```

Startup output:

```text
INFO:     Started server process [342629]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:18079 (Press CTRL+C to quit)
```

HTTP check 1:

```text
GET /health
HTTP/1.1 200 OK
{"status":"ok","service":"owner-roster-registry","version":"0.1.0"}
```

HTTP check 2:

```text
GET /api/v1/companies/acme-helpdesk/cloud-snapshot
HTTP/1.1 200 OK
```

Response body facts:

- returned `schema_version: "0.1"`
- returned populated `company`, `position_groups`, and `roster`
- returned `validated_receipt_hashes`
- returned a `snapshot_hash`
- returned the disclaimer text

Shutdown:

```text
^C
INFO:     Shutting down
INFO:     Waiting for application shutdown.
INFO:     Application shutdown complete.
INFO:     Finished server process [342629]
```

Shutdown completed cleanly: yes

## E. Classification

`TEST_HARNESS_FAILURE`

Reason:

- live `uvicorn` HTTP served successfully;
- the in-process `TestClient` path hung;
- a trivial control FastAPI app under the same environment also hung during in-process request execution.

## F. Claim Impact

- CLI proof remains valid: yes
- local export proof remains valid: yes
- API proof is invalidated in this audit environment: yes
- DefendableCloud integration readiness must be held: yes

## G. Recommendation

- Hold release claims that rely on published API test proof.
- Preserve current CLI and export evidence as separately valid.
- Perform repair analysis later in a dedicated environment pass focused on the in-process ASGI test stack.
