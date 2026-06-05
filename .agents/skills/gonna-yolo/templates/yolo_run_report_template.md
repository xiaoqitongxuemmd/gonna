# Deprecated YOLO Run Report

Do not use this template for normal yolo execution.

`docs/run/` is reserved for yolo blockers and abnormal stops. A yolo run report must not become an all-in-one document that covers implementation details, test evidence, submission details, and selftest evidence.

Use downstream artifacts instead:

- `gonna-dev` owns implementation reports.
- `gonna-test` owns test plans, test reports, defect reports, and completion recommendations.
- `gonna-submit` owns commit plans, submission reports, and MR/PR descriptions.
- `gonna-selftest` owns selftest documents and assets.

For blockers or abnormal stops, use:

- `.agents/skills/gonna-yolo/templates/blocker_report_template.md`
