[WIP]

# HOW-TO

## UPGRADE --INSTALL
`--dry-run` - simulates an install

`--debug` - enables verbose output

`--verify` - verifies the package before installing it

`--atomic` - installation process purges chart on fail, the `--wait` flag will be set automatically

### DRY-RUN
```
helm upgrade ra-1-0-0 --install \
  --dry-run --debug \
  --set global.services.customerInsights.enabled=true \
  --set global.services.customerInsights.version="1.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### UPGRADE Customer Insights
```
helm upgrade ra-1-0-0 --install \
  --atomic \
  --set global.services.customerInsights.enabled=true \
  --set global.services.customerInsights.version="1.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### UPGRADE Price Sensitivity
```
helm upgrade ra-1-0-0 --install \
  --atomic \
  --set global.services.priceSensitivity.enabled=true \
  --set global.services.priceSensitivity.version="2.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```

### UPGRADE All
```
helm upgrade ra-1-0-0 --install \
  --atomic \
  --set global.services.customerInsights.enabled=true \
  --set global.services.customerInsights.version="1.0" \
  --set global.services.priceSensitivity.enabled=true \
  --set global.services.priceSensitivity.version="2.0" \
  --values values.yaml \
  --values values-dev.yaml \
  .
```
