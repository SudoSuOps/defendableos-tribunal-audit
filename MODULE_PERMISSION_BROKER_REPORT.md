# Permission Broker Diagnostic Report

Module: `permission-broker`  
Commit: `7229e21d77f45e0b1cd68a51870cf479af3a6cab`  
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
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from broker import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
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

- `permission-broker/broker/app.py:22`

## C. Pytest Reproduction

Command:

```bash
timeout 20s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -vv -s --setup-show permission-broker/tests/test_api.py::test_unknown_agent_denied
```

Output before timeout:

```text
============================= test session starts ==============================
platform linux -- Python 3.13.7, pytest-9.0.3, pluggy-1.6.0 -- /usr/bin/python3
cachedir: .pytest_cache
rootdir: defendableos-tribunal-audit
collecting ... collected 1 item

permission-broker/tests/test_api.py::test_unknown_agent_denied
SETUP    S tmp_path_factory
        SETUP    F tmp_path (fixtures used: tmp_path_factory)
        SETUP    F cfg (fixtures used: tmp_path)
        SETUP    F conn (fixtures used: cfg)
        SETUP    F ready (fixtures used: cfg, conn)
        SETUP    F monkeypatch
        permission-broker/tests/test_api.py::test_unknown_agent_denied (fixtures used: cfg, conn, monkeypatch, ready, request, tmp_path, tmp_path_factory)
```

Conclusion:

- collection: completed
- fixture setup: completed
- client construction vs request: pytest output alone does not distinguish
- minimal reproduction outside pytest proves the actual stall occurs on `client.get("/health")`

Referenced failing test:

- `permission-broker/tests/test_api.py:15`

## D. Live Server Comparison

Disposable audit run-copy used:

- temporary permission-broker run-copy

Preparation:

- `python3 cli/broker_cli.py init`
- `python3 cli/broker_cli.py import-registry --file examples/source_registry_snapshot/cloud_snapshot.json`
- `python3 cli/broker_cli.py compile-policy --company acme-helpdesk --position-group customer_support`
- `python3 cli/broker_cli.py execute --actor support-02.acme.defendable.eth --action classify_ticket --payload examples/action_requests/backup_classify_ticket.json`
- `python3 cli/broker_cli.py execute --actor support-02.acme.defendable.eth --action issue_refund --payload examples/action_requests/backup_attempt_issue_refund.json`
- `python3 cli/broker_cli.py request-approval --actor support-02.acme.defendable.eth --action request_refund_review --payload examples/action_requests/human_approval_request_refund.json`

Startup command:

```bash
python3 -m uvicorn broker.app:app --host 127.0.0.1 --port 18089
```

Startup output:

```text
INFO:     Started server process [342631]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:18089 (Press CTRL+C to quit)
```

HTTP check 1:

```text
GET /health
HTTP/1.1 200 OK
{"status":"ok","service":"permission-broker","version":"0.1.0","honest_claim":"Permission Broker v0.1 proves local policy enforcement for broker-routed actions using owner-approved roster evidence and hash-verified enforcement receipts. It does not restrict external platforms, credentials, integrations, or agents acting outside this gateway."}
```

HTTP check 2:

```text
GET /api/v1/companies/acme-helpdesk/enforcement-summary
HTTP/1.1 200 OK
```

Response body facts:

- returned `policy_id` and `policy_hash`
- returned `source_registry_snapshot_hash`
- returned `action_counts_by_decision`
- returned blocked sensitive action evidence
- returned queued human approval evidence
- returned `external_enforcement_claimed: false`

Shutdown:

```text
^C
INFO:     Shutting down
INFO:     Waiting for application shutdown.
INFO:     Application shutdown complete.
INFO:     Finished server process [342631]
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
- DefendableCloud / API transition readiness must be held: yes
- Permission Broker CLI enforcement proof remains independently supported while API execution proof is held: yes

## G. Recommendation

- Hold API-backed release proof until the in-process request path is re-established in a repair analysis pass.
- Preserve the independently supported CLI enforcement claim, but do not let it substitute for failed API proof.
