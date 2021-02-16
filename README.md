# polder
POLDER project infrastructure configuration

# k8s deployment

1. Fill the empty strings in the `override-values-example.yaml` file and rename it to `override-values.yaml`
2. Execute:
    ```console
    k8s@wealize:~$ helm upgrade --install --create-namespace --atomic -f override-values.yaml polder ./charts/polder --namespace polder
    ```
