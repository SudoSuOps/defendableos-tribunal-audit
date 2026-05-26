# Exact Execution Commands

## Owner Roster Registry TestClient Reproduction

```bash
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from registry import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
```

Expected observed output before timeout:

```text
before TestClient
after TestClient
```

## Permission Broker TestClient Reproduction

```bash
timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from broker import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
```

Expected observed output before timeout:

```text
before TestClient
after TestClient
```

## Owner Roster Registry Failing Pytest File

```bash
timeout 20s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -vv -s --setup-show owner-roster-registry/tests/test_cloud_api.py::test_cloud_snapshot_endpoint
```

## Permission Broker Failing Pytest File

```bash
timeout 20s env PYTEST_DISABLE_PLUGIN_AUTOLOAD=1 python3 -m pytest -vv -s --setup-show permission-broker/tests/test_api.py::test_unknown_agent_denied
```

## Trivial FastAPI Control Reproduction

```bash
timeout 20s python3 -u -c "from fastapi import FastAPI; from fastapi.testclient import TestClient; app=FastAPI(); app.add_api_route('/health', lambda: {'ok': True}, methods=['GET']); print('before TestClient'); client=TestClient(app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
```

Expected observed output before timeout:

```text
before TestClient
after TestClient
```

## Trivial ASGI Transport Control Reproduction

```bash
timeout 10s python3 -u -c $'import asyncio\nimport httpx\nfrom fastapi import FastAPI\napp = FastAPI()\napp.add_api_route("/health", lambda: {"ok": True}, methods=["GET"])\nprint("before async client")\nasync def main():\n    transport = httpx.ASGITransport(app=app)\n    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:\n        print("before request")\n        resp = await client.get("/health")\n        print("after response", resp.status_code, resp.text)\nasyncio.run(main())'
```

Expected observed output before timeout:

```text
before async client
before request
```
