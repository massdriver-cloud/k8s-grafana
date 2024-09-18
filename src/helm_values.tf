locals {
  helm_values = {
    commonLabels = module.application.params.md_metadata.default_tags
    pod = {
      annotations = {
        "md-deployment-tag" = lookup(module.application.params.md_metadata.deployment, "id", "")
      }
    }
    envs           = [for key, val in module.application.envs : { name = key, value = tostring(val) }]
    serviceAccount = local.cloud_service_accounts[module.application.cloud]
    labels         = var.md_metadata.default_tags
  }
}
