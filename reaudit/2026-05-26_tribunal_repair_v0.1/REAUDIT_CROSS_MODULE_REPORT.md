# Fresh Cross-Module Re-Run

## Field Test Result

The repaired public commits preserved the previously verified limited end-to-end behavior.

1. Fresh Conditioning evidence was generated for `support-01.acme.defendable.eth`.
2. Fresh Swarm-Doctor continuity evidence was generated for the same workflow.
3. A clean repaired Registry was initialized and both fresh receipts were imported.
4. Conditioning recommendation alone moved the starter to `DOCTOR_REVIEW_REQUIRED` while leaving owner-approved state at `ACTIVE_STARTER`.
5. Swarm-Doctor continuity evidence moved the starter recommendation to `INJURED_RESERVE_RECOMMENDED` and the backup recommendation to `ACTIVE_BACKUP_RESTRICTED_DUTY`.
6. The covering action remained separated correctly.
7. Starter did not receive `BACKUP_RESTRICTED_DUTY`.
8. Backup carried `continuity_assignment = BACKUP_RESTRICTED_DUTY`.
9. Position group carried `coverage_state = COVERED_BY_BACKUP_RESTRICTED_DUTY`.
10. Owner decision recorded for starter: `INJURED_RESERVE`.
11. Owner decision recorded for backup: `ACTIVE_BACKUP_RESTRICTED_DUTY`.
12. A fresh Registry cloud snapshot was exported.
13. A clean repaired Broker imported that snapshot and compiled policy.
14. Broker enforcement preserved prior limited behavior: `classify_ticket` executed locally.
15. Broker enforcement preserved prior limited behavior: `issue_refund` was denied.
16. Broker enforcement preserved prior limited behavior: `request_refund_review` was queued for human approval.
17. Direct broker state inspection confirmed one allowed local mock execution.
18. Direct broker state inspection confirmed zero refund mock executions.
19. Direct broker state inspection confirmed one queued human approval request.
20. Direct broker state inspection confirmed `external_enforcement_claimed = false`.
21. Registry and Broker regenerated export artifacts carried the integrity-only hash limitation language.

## Cross-Module Evidence Highlights

### Registry State

- After fresh Conditioning receipt: `recommended_state = DOCTOR_REVIEW_REQUIRED`
- After fresh Conditioning receipt: `owner_approved_state = ACTIVE_STARTER`
- After fresh Conditioning receipt: `enforcement_state = NOT_ENFORCED`
- After fresh Swarm-Doctor receipt: starter `recommended_state = INJURED_RESERVE_RECOMMENDED`
- After fresh Swarm-Doctor receipt: backup `recommended_state = ACTIVE_BACKUP_RESTRICTED_DUTY`
- After fresh Swarm-Doctor receipt: backup `continuity_assignment = BACKUP_RESTRICTED_DUTY`
- After fresh Swarm-Doctor receipt: position-group `coverage_state = COVERED_BY_BACKUP_RESTRICTED_DUTY`

### Broker State

- Allowed action receipt decision: `ALLOW_AND_EXECUTE_LOCAL_MOCK`
- Denied refund receipt decision: `DENY_ACTION_NOT_IN_PERMISSION_ENVELOPE`
- Queued review receipt decision: `QUEUE_FOR_HUMAN_APPROVAL`
- Local side-effect count for refund: `0`
- Local side-effect count for allowed mock execution: `1`

## Cross-Module Verdict

Cross-module result: `VERIFIED_AS_REPAIRED_WITH_LIMITATIONS`

Reason:

- the repaired release-proof API path is now reproducible over live localhost HTTP;
- the verified limited business-state and local broker-enforcement claims remain intact;
- the in-process `TestClient` path still cannot be counted as clean proof in this Codex environment.
