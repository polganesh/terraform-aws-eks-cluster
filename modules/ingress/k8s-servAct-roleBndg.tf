resource "kubernetes_cluster_role" "ingress" {
  count  = var.enable_ingress_config ? 1 : 0
  metadata {
    name = "alb-ingress-controller"
    labels = {
      "app.kubernetes.io/name"       = "alb-ingress-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs      = ["create", "get", "list", "update", "watch", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "ingress" {
  count  = var.enable_ingress_config ? 1 : 0
  metadata {
    name = "alb-ingress-controller"
    labels = {
      "app.kubernetes.io/name"       = "alb-ingress-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.ingress[0].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.ingress[0].metadata[0].name
    namespace = kubernetes_service_account.ingress[0].metadata[0].namespace
  }

  depends_on = [kubernetes_cluster_role.ingress]
}

resource "kubernetes_service_account" "ingress" {
  count  = var.enable_ingress_config ? 1 : 0
  automount_service_account_token = true
  metadata {
    name      = "alb-ingress-controller"
    namespace = "kube-system"
    labels    = {
      "app.kubernetes.io/name"       = "alb-ingress-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
    annotations = {
      # for more info refer iam-alb-ingress-policy-role.tf
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_alb_ingress_controller[0].arn
    }
  }
}