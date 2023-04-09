REGISTRY_PORT:=13004

.PHONY: cluster
cluster:
	k3d registry create rmcluster.localhost --port $(REGISTRY_PORT)
	k3d cluster create rmcluster --registry-use k3d-rmcluster.localhost:$(REGISTRY_PORT)

.PHONY: clean
clean:
	k3d cluster delete rmcluster

.PHONY: local-helm-install
local-helm-install:
	helm upgrade --install landmine . --set image.registry=k3d-rmcluster.localhost:$(REGISTRY_PORT)
