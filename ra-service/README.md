# ABOUT
Helm (v3) playground :sweat_smile:

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

### DRY-RUN
```
helm upgrade ra --install \
  --dry-run --debug \
  --set global.services.customerInsights.enabled=true \
  --set global.services.customerInsights.version="2.0" \
  --set global.services.priceSensitivity.enabled=true \
  --set global.services.priceSensitivity.version="1.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### DEPLOY
```
helm upgrade ra --install \
  --atomic \
  --set global.services.customerInsights.enabled=true \
  --set global.services.customerInsights.version="2.0" \
  --set global.services.priceSensitivity.enabled=true \
  --set global.services.priceSensitivity.version="1.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```
