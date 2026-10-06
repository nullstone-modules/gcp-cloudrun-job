# 0.2.0 (Oct 6, 2026)
* Upgraded `nullstone-io/ns` provider to `~> 0.13.0`.
* Replaced `ns_env_variables` and `ns_secret_keys` with the layered `ns_env_layout`, `ns_env_values`, and `ns_env_platform_data` data sources to aggregate environment variables and secrets.
* Emitted the `env` platform data record, including the source of each variable and the Secret Manager secret id of each managed secret.
* Reported the variable Cloud Run injects into the job (`CLOUD_RUN_JOB`) in the `cloud` layer of the `env` platform data record.
* Upgraded capability scaffolding to emit `capability` on capability outputs and `cap_prefixes`.
* Artifact Registry repository now carries the workspace label set from `gcp_labels` (`stack`, `env`, `block`, `owner`, `project`, `application`, `component`, ...) so Nullstone cost attribution can see it. Existing repos are relabeled in place on the next apply; the old `nullstone-stack`, `nullstone-env`, and `nullstone-block` keys are removed.

# 0.1.0 (Jun 19, 2026)
* Initial release
