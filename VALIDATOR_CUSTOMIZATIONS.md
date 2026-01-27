# Tag Validator Customizations

This document lists what Checkov and OPA **do NOT naturally have** out-of-the-box, and what we implemented to get them working properly for MoJ tag validation.

## Problem Statement

Cloud Platform uses a **module-based tagging pattern**:
- Provider `default_tags` only contains `source-code` and `slack-channel`
- Other required tags are passed as **inputs to modules** (e.g., `module "rds" { application = var.application }`)
- Static file scanning cannot see the actual tags applied to resources

**Neither Checkov nor OPA naturally handle this without customization.**

---

## Checkov Customizations

### What Checkov Doesn't Have Naturally

| Missing Feature | Why It's Needed |
|-----------------|-----------------|
| MoJ-specific tag validation | Checkov has generic tag checks, not MoJ's specific required tags |
| Module input tag detection | Static scanning can't see tags passed to modules |
| `tags_all` awareness | Default checks don't prioritize `tags_all` over `tags` |
| Configurable required tags | No easy way to specify custom tag requirements per-run |

### What We Implemented

1. **Custom Policy (`policies/required_tags.py` and `required_tags_plan.py`)**
   - Custom Checkov check `CKV_AWS_TAG_001`
   - Loads required tags from config file
   - Checks both `tags` and `tags_all` attributes
   - Reports missing and empty tag values

2. **Plan-Based Scanning**
   - Changed from static file scanning (`-d .`) to plan scanning (`-f tfplan.json`)
   - Uses `--framework terraform_plan` instead of `--framework terraform`
   - Requires `terraform init` and `terraform plan` steps

3. **Dynamic Config Generation (`scripts/generate_config.py`)**
   - Generates `config.json` from workflow input
   - Allows customizable required tags per repository

4. **`__init__.py` in policies folder**
   - Required for Checkov to load external Python checks as a module

5. **Dummy AWS Credentials**
   - Added dummy AWS credentials for terraform plan in CI (no actual API calls)
   - Required because skip_credentials_validation alone isn't sufficient

---

## OPA Customizations

### What OPA/Conftest Doesn't Have Naturally

| Missing Feature | Why It's Needed |
|-----------------|-----------------|
| Tag validation policy | OPA is a generic policy engine, no built-in tag checks |
| Terraform plan integration | Conftest doesn't generate plans, only validates them |
| MoJ tag requirements | No pre-built MoJ-specific policies |
| GitHub Action packaging | No ready-to-use action for tag validation |
| Non-taggable resource filtering | OPA checks ALL resources, not just taggable ones |

### What We Implemented

1. **Dynamic Rego Policy Generation (`scripts/generate_policy.py`)**
   - Generates `policies/tags.rego` at runtime
   - Configurable required tags from workflow input
   - Checks for missing tags AND empty tag values
   - Uses `tags_all` with fallback to `tags`
   - **OPA 1.0+ compatible syntax** (`import rego.v1`, `contains`, `if` keywords)
   - **`supports_tags` check** to skip non-taggable resources

2. **Conftest Installation**
   - Manual installation via curl (no official setup action exists)
   - Pinned to specific version (0.66.0)

3. **Terraform Plan Generation**
   - `terraform init -backend=false`
   - `terraform plan -out=tfplan.binary`
   - `terraform show -json tfplan.binary > tfplan.json`
   - Dummy AWS credentials for CI environments

4. **Result Parsing (`scripts/parse_results.py`)**
   - Parses Conftest JSON output
   - Generates GitHub-compatible markdown summary
   - **Proper error handling** - reports errors instead of silent pass

---

## Comparison: What Each Tool Required

| Customization | Checkov | OPA |
|---------------|---------|-----|
| Custom policy file | ✅ Python | ✅ Rego |
| Policy loader/init file | ✅ `__init__.py` | ❌ Not needed |
| Config generator | ✅ Yes | ✅ Yes |
| Result parser | ✅ Yes | ✅ Yes |
| Terraform plan generation | ✅ Added | ✅ Added |
| Tool installation | ✅ pip install | ✅ curl download |
| Framework change | ✅ `terraform` → `terraform_plan` | ❌ N/A |
| Dummy AWS credentials | ✅ Yes | ✅ Yes |
| OPA 1.0+ syntax update | ❌ N/A | ✅ Required |
| Non-taggable resource filtering | ❌ Built-in | ✅ Added `supports_tags` |

---

## Key Insights

1. **Both tools require terraform plan** to properly validate module-based resources
2. **AWS credentials are needed** in CI/CD (dummy creds work for plan generation)
3. **Static file scanning is insufficient** for Cloud Platform's module pattern
4. **OPA requires more customization** (Rego syntax, taggable resource filtering)
5. **Checkov is simpler** but reports at resource level vs OPA's tag-level detail

---

## Test Results

| Test Case | Checkov | OPA |
|-----------|---------|-----|
| `module.compliant_bucket` (all tags) | ✅ PASS | ✅ PASS |
| `module.non_compliant_bucket` (empty tags) | ❌ FAIL | ❌ FAIL (2 violations) |
| `aws_s3_bucket.direct_bucket_no_tags` | ❌ FAIL | ❌ FAIL (6 violations) |

---

## Files Modified/Created

### Checkov Tag Validator
- `action.yml` - Added terraform setup, plan generation, dummy AWS creds
- `policies/__init__.py` - Created (required for external checks)
- `policies/required_tags.py` - Custom tag check for static files
- `policies/required_tags_plan.py` - Custom tag check for plan JSON
- `scripts/generate_config.py` - Config generator
- `scripts/parse_results.py` - Result parser

### OPA Tag Validator
- `action.yml` - Conftest installation, terraform plan, dummy AWS creds
- `scripts/generate_policy.py` - Dynamic Rego policy generator (OPA 1.0+ syntax)
- `scripts/parse_results.py` - Result parser with proper error handling
- `policies/` - Empty folder (policy generated at runtime)
