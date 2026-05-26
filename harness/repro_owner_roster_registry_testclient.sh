#!/usr/bin/env bash
set -euo pipefail

timeout 20s python3 -u -c "from fastapi.testclient import TestClient; from registry import app as appmod; print('before TestClient'); client=TestClient(appmod.app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
