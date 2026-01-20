.PHONY: build 
build: 
	docker build -f docker/dockerfiles/opencode -t opencode .

.PHONY: gen-env
gen-env:
	echo "DOCKERDOCENT_REPO_PATH=$(shell pwd)" > .env
