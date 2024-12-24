.PHONY: local-helm-install
local-helm-install:
	$(eval CERT=$(shell cat rmcert.pem | base64))
	$(eval KEY=$(shell cat rmkey.pem | base64))
	helm upgrade --install landmine . \
		--set ingress.cert="$(CERT)" \
		--set ingress.key="$(KEY)" \
		--set landmine.notificationWebhook=${NOTIFICATION_WEBHOOK}
