# DO NOT EDIT. Generated with:
#
#    devctl@6.14.0
#

##@ Schema

VALUES=$(shell find ./helm -maxdepth 2 -name values.yaml)
VALUES_SCHEMA=$(shell find ./helm -maxdepth 2 -name values.schema.json)
CHART_README=$(shell find ./helm -maxdepth 2 -name README.md)

.PHONY: normalize-schema
normalize-schema: ## Normalize the JSON schema
	go install github.com/giantswarm/schemalint/v2@v2
	schemalint normalize $(VALUES_SCHEMA) -o $(VALUES_SCHEMA) --force

.PHONY: validate-schema
validate-schema: ## Validate the JSON schema
	go install github.com/giantswarm/schemalint/v2@v2
	schemalint verify $(VALUES_SCHEMA) --rule-set=cluster-app

.PHONY: generate-docs
generate-docs: ## Generate values documentation from schema
	go install github.com/giantswarm/schemadocs@latest
	schemadocs generate $(VALUES_SCHEMA) -o $(CHART_README)

.PHONY: generate-values
generate-values: ## Generate values.yaml from schema
	go install github.com/giantswarm/helm-values-gen@v1
	helm-values-gen $(VALUES_SCHEMA) -o $(VALUES) --force

