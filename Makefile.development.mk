.DEFAULT_GOAL:=help

##@ Build

TEST_CASE ?=
ifdef TEST_CASE
CI_FILE = "ci/test-$(TEST_CASE)-values.yaml"
else
CI_FILE ?= "ci/ci-values.yaml"
endif

APPLICATION="helm/cluster-cloud-director"

.PHONY: template
template: ## Output the rendered Helm template
	$(eval CHART_DIR := "helm/cluster-cloud-director")
	$(eval HELM_RELEASE_NAME := $(shell yq .global.metadata.name ${CHART_DIR}/${CI_FILE}))
	$(eval ORG_NAME := org-$(shell yq .global.metadata.organization ${CHART_DIR}/${CI_FILE}))
	@helm template -n ${ORG_NAME} ${HELM_RELEASE_NAME} ${CHART_DIR} --values ${CHART_DIR}/${CI_FILE} --debug

.PHONY: generate
generate: normalize-schema validate-schema generate-docs generate-values update-deps
