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

## HELM UPGRADE options
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
