# ABOUT
Helm (v3) playground :sweat_smile:

# TODO
* Ingress paths existence based on `enabled` value
* ... many many things ...

# HOW-TO

## REQUIREMENTS
* Namespace: `demo`
* Nginx Ingress controller
* ExternalDNS
* Linkerd

## HELM

### UPGRADE options
`--dry-run` - simulates an install

`--debug` - enables verbose output

`--verify` - verifies the package before installing it

`--atomic` - installation process purges chart on fail, the `--wait` flag will be set automatically

`--reuse-values` - when upgrading, reuse the last release's values

### DRY-RUN
```
helm upgrade ra --install \
  --dry-run --debug \
  --set global.services.customerInsights.version="1.0" \
  --set global.services.priceSensitivity.version="2.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### DEPLOY all
```
helm upgrade ra --install \
  --atomic \
  --set global.services.customerInsights.version="1.0" \
  --set global.services.priceSensitivity.version="2.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### UPDATE specific microservice only (ex. Customer Insights)
```
helm upgrade ra --install \
  --reuse-values \
  --atomic \
  --set global.services.customerInsights.version="2.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

## K8S resources
```
$ helm ls
NAME	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART               	APP VERSION
ra  	demo     	8       	2020-01-15 16:25:54.562326 +0100 CET	deployed	retail-analytics-1.0
```
```
$ kubectl get configmaps
NAME                DATA   AGE
customer-insights   2      58m
price-sensitivity   2      21m
```
```
$ kubectl get deploy
NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
customer-insights     1/1     1            1           58m
price-sensitivity     1/1     1            1           21m
```
```
$ kubectl get svc
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
customer-insights      ClusterIP   172.20.66.251   <none>        6666/TCP       58m
price-sensitivity      ClusterIP   172.20.178.90   <none>        7777/TCP       21m
```
```
$ kubectl get ing
NAME               HOSTS                           ADDRESS                                                       PORTS   AGE
retail-analytics   ra.k8s.sebolabs.net             aabbbcccddd111222333-l1k2j3h4g5.elb.eu-west-1.amazonaws.com   80      58m
```

## LINKERD
```
$ linkerd stat deployments -n demo
NAME                  MESHED   SUCCESS      RPS   LATENCY_P50   LATENCY_P95   LATENCY_P99   TCP_CONN
customer-insights        1/1   100.00%   0.1rps           0ms           0ms           0ms          2
price-sensitivity        1/1   100.00%   0.1rps           0ms           0ms           0ms          2
```
```
$ linkerd top deploy/customer-insights -n demo
Source                                     Destination                         Method      Path   Count    Best   Worst    Last  Success Rate
nginx-ingress-controller-84b94c46f9-lqch9  customer-insights-6f75b77cbd-vl5dg  GET         /          9   436µs   776µs   436µs       100.00%
```
```
$ linkerd tap deploy/customer-insights -n demo
req id=1:0 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote :method=GET :authority=ra.k8s.sebolabs.net :path=/
rsp id=1:0 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote :status=200 latency=434µs
end id=1:0 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote duration=29µs response-length=74B
req id=1:1 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote :method=GET :authority=ra.k8s.sebolabs.net :path=/
rsp id=1:1 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote :status=200 latency=415µs
end id=1:1 proxy=in  src=10.123.1.128:49400 dst=10.123.1.132:8080 tls=not_provided_by_remote duration=32µs response-length=74B
```
