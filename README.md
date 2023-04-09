# landmine-helm

Testing ingress with certs.

> Requires mkcert

### Run

```shell
mkcert -cert-file rmcert.pem -key-file rmkey.pem "*.landmine.app" "*.versomas.net" "versomas.net" 
```

### Apply Chart

```shell
make local-helm-install
```
