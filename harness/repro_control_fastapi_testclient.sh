#!/usr/bin/env bash
set -euo pipefail

timeout 20s python3 -u -c "from fastapi import FastAPI; from fastapi.testclient import TestClient; app=FastAPI(); app.add_api_route('/health', lambda: {'ok': True}, methods=['GET']); print('before TestClient'); client=TestClient(app); print('after TestClient'); resp=client.get('/health'); print('after response', resp.status_code, resp.text)"
