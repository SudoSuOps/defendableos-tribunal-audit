#!/usr/bin/env bash
set -euo pipefail

timeout 10s python3 -u -c $'import asyncio\nimport httpx\nfrom fastapi import FastAPI\napp = FastAPI()\napp.add_api_route("/health", lambda: {"ok": True}, methods=["GET"])\nprint("before async client")\nasync def main():\n    transport = httpx.ASGITransport(app=app)\n    async with httpx.AsyncClient(transport=transport, base_url="http://testserver") as client:\n        print("before request")\n        resp = await client.get("/health")\n        print("after response", resp.status_code, resp.text)\nasyncio.run(main())'
