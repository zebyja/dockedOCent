.PHONY: build
build: 
	docker build -f docker/dockerfiles/opencode -t opencode .