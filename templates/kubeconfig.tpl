# See https://github.com/kubernetes/cloud-provider-openstack/blob/master/docs/using-client-keystone-auth.md
apiVersion: v1
kind: Config
users:
- name: ${username}
  user:
    exec:
      # Command to execute. Required.
      command: "${auth_plugin}"

      # API version to use when encoding and decoding the ExecCredentials
      # resource. Required.
      #
      # The API version returned by the plugin MUST match the version encoded.
      apiVersion: "client.authentication.k8s.io/v1beta1"

      # Arguments to pass when executing the plugin. Optional.
      args:
      - "--domain-name=${domain_name}"
      - "--keystone-url=${auth_url}"
      - "--project-name=${tenant_name}"
      - "--user-name=${username}"
      - "--password=${password}"
      - "--v=10"
clusters:
- name: ${cluster_name}
  cluster:
    server: "${api_server_url}"
    insecure-skip-tls-verify: true
contexts:
- name: ${cluster_name}
  context:
    cluster: ${cluster_name}
    user: ${username}
current-context: ${cluster_name}
