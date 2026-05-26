# Fresh Interoperation And Side Effects

## Fresh Interop

1. Fresh registry run-copy exported a cloud snapshot with hash:
   - `4b87d7a116bb47ea5a97e58bd84a83f23a5928036c1443d7107b897cab38a458`
2. Fresh clean broker run-copy imported that exact snapshot hash.
3. Fresh clean broker run-copy compiled a policy that referenced the same imported snapshot hash.

## Broker Side Effects

Executed on a clean broker interop run-copy:

- `classify_ticket` -> `ALLOW_AND_EXECUTE_LOCAL_MOCK`
- `issue_refund` -> `DENY_ACTION_NOT_IN_PERMISSION_ENVELOPE`
- `request_refund_review` -> `QUEUE_FOR_HUMAN_APPROVAL`

State inspection result:

- exactly one local mock record existed
- no forbidden refund execution record was created
- queued human approval existed without sensitive action execution
