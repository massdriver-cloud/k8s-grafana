module "massdriver_helm_values" {
  source                 = "github.com/massdriver-cloud/terraform-modules//massdriver-helm-values"
  massdriver_application = module.application
}

locals {
  helm_values = {
      serviceAccount = merge({
      # explicitly set the service account name
      name = var.md_metadata.name_prefix
    }, module.massdriver_helm_values.k8s_service_account)
  }
}
