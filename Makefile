PROJECT_NAME="crypto-marketplace"
PODS_ROOT=./Pods

.DEFAULT_GOAL := help

loc_syntax: ## Checks .strings files syntax
	plutil -lint ./${PROJECT_NAME}/Resources/**/*.strings

swiftgen: ## Regenerate swiftgen dependencies
	${PODS_ROOT}/SwiftGen/bin/swiftgen

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
