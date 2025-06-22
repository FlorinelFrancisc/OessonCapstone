output "jenkins_public_ip" {
  value = aws_instance.jenkins_host.public_ip
}

output "k8s_node_ips" {
  value = [
    aws_instance.k8s_node_a.public_ip,
    aws_instance.k8s_node_b.public_ip
  ]
}
