# Validators Test Playground

Test playground for evaluating AWS tag enforcement tools (Checkov, OPA, terraform-tag-validator) on Cloud Platform-style Terraform resources.

## Structure

```
environments/
└── tag-test-dev/
    ├── main.tf
    ├── variables.tf
    ├── versions.tf
    └── [AWS resource files]
```

## Related

- [Spike #540](https://github.com/ministryofjustice/cloud-optimisation-and-accountability/issues/540)
- [Pilot #555](https://github.com/ministryofjustice/cloud-optimisation-and-accountability/issues/555)
- [tag-enforcement-spike](https://github.com/FolarinOyenuga/tag-enforcement-spike)
