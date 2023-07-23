.PHONY: cluster
cluster:
	k3d cluster create rmcluster \
		--api-port 6443 --agents 1 \
		-p "443:443@loadbalancer" \
		-p "5300:30001/tcp@agent:0" \
		-p "5300:30002/udp@agent:0" \
		-p "3389:30003/tcp@agent:0" \
		-p "2500:30004/tcp@agent:0"

.PHONY: clean
clean:
	k3d cluster delete rmcluster

.PHONY: local-helm-install
local-helm-install:
	$(eval CERT=$(shell cat rmcert.pem | base64))
	$(eval KEY=$(shell cat rmkey.pem | base64))
	helm upgrade --install landmine . \
		--set ingress.cert="$(CERT)" \
		--set ingress.key="$(KEY)" \
		--set landmine.notificationWebhook=${NOTIFICATION_WEBHOOK}

.PHONY: recycle
recycle: clean cluster local-helm-install
