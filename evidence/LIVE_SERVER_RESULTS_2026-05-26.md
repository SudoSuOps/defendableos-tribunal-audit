# Live Server Results

## Owner Roster Registry

Startup command:

```bash
python3 -m uvicorn registry.app:app --host 127.0.0.1 --port 18079
```

Startup result:

```text
INFO:     Started server process [...]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:18079 (Press CTRL+C to quit)
```

HTTP:

- `GET /health` -> `200 OK`
- `GET /api/v1/companies/acme-helpdesk/cloud-snapshot` -> `200 OK`

Shutdown:

```text
^C
INFO:     Shutting down
INFO:     Waiting for application shutdown.
INFO:     Application shutdown complete.
INFO:     Finished server process [...]
```

## Permission Broker

Startup command:

```bash
python3 -m uvicorn broker.app:app --host 127.0.0.1 --port 18089
```

Startup result:

```text
INFO:     Started server process [...]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:18089 (Press CTRL+C to quit)
```

HTTP:

- `GET /health` -> `200 OK`
- `GET /api/v1/companies/acme-helpdesk/enforcement-summary` -> `200 OK`

Shutdown:

```text
^C
INFO:     Shutting down
INFO:     Waiting for application shutdown.
INFO:     Application shutdown complete.
INFO:     Finished server process [...]
```
