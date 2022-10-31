locals {
  chart_version = "6.42.2"
}

module "application" {
  source  = "github.com/massdriver-cloud/terraform-modules//massdriver-application"
  name    = var.md_metadata.name_prefix
  service = "kubernetes"

  kubernetes = {
    namespace        = var.namespace
    cluster_artifact = var.kubernetes_cluster
  }
}

resource "helm_release" "main" {
  name             = var.md_metadata.name_prefix
  chart            = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values)
  ]
}
