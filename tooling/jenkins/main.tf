resource "kubernetes_namespace" "jenkins" {
    metadata {
        name = "jenkins"
        labels = {
            "app.kubernetes.io/managed-by" = "terraform"
        }
    }
}

resource "kubernetes_deployment" "jenkins-deployment" {
    metadata {
        name = "jenkins-master-deployment"
        namespace = kubernetes_namespace.jenkins.metadata.0.name
        labels = {
            "service" = "jenkins-master-service"
            "app.kubernetes.io/managed-by" = "terraform"
        }
    }
    spec {
        replicas = 1
        strategy {
            type = "Recreate"
        }
        selector {
            match_labels = {
                service = "jenkins-master-service"
            }
        }
        template {
            metadata {
                name = "jenkins-master"
                namespace = kubernetes_namespace.jenkins.metadata.0.name
                labels = {
                    "service" = "jenkins-master-service"
                    "app.kubernetes.io/managed-by" = "terraform"
                }
            }
            spec {
                container {
                    image = "${var.registry_url}/${var.jenkins_docker_image}:${var.jenkins_docker_image_version}"
                    name = "jenkins-master"
                    env {
                        name = "JENKINS_OPTS"
                        value = "--prefix=/jenkins"
                    }
                    volume_mount {
                        name = "jenkins-volume"
                        sub_path = "jenkins"
                        mount_path = "/var/jenkins_home"
                    }
                    readiness_probe {
                        initial_delay_seconds = 60
                        period_seconds = 15
                        failure_threshold = 5
                        http_get {
                            scheme = "HTTP"
                            path = "/jenkins/login"
                            port = "8080"
                        }
                    }
                    security_context {
                        // GKE mounts volume as root. Container started as non-root can't access volume
                        privileged = true
                        allow_privilege_escalation = true
                    }
                    port {
                        name = "http-port"
                        container_port = 8080
                    }
                    port {
                        name = "jnlp-port"
                        container_port = 50000
                    }
                }
                volume {
                    name = "jenkins-volume"
                    gce_persistent_disk {
                        pd_name = var.pd_name
                    }
                }
            }
        }
    }
}

resource "kubernetes_service" "jenkins-master" {
    metadata {
        name = "jenkins-master-service"
        namespace = kubernetes_namespace.jenkins.metadata.0.name
        labels = {
            "app.kubernetes.io/managed-by" = "terraform"
        }
    }
    spec {
        type = "LoadBalancer"
        selector = {
            service = kubernetes_deployment.jenkins-deployment.metadata[0].labels.service
        }
        session_affinity = "ClientIP"
        port {
            name = "https"
            port = 80
            target_port = 8080
        }
        port {
            name = "jnlp-port"
            port = 50000
            target_port = 50000
        }
    }
}
