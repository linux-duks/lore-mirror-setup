# if Podman is available, prefer using it over docker
ifeq ($(shell command -v podman 2> /dev/null),)
    CONTAINER=docker
else
    CONTAINER=podman
endif

.PHONY: pull
pull:
	@if [ ! -d ./data/ ]; then \
		echo "==> data firectory missing. Creating first..."; \
		mkdir ./data; \
	fi
	cd grokmirror && $(CONTAINER)-compose up -d && $(CONTAINER)-compose logs -f

.PHONY: pull-off
pull-off:
	cd grokmirror && $(CONTAINER)-compose down -v

.PHONY: serve
serve:
	@if [ ! -d ./data/ ]; then \
		echo "==> data firectory missing. Pull data first..."; \
		exit 1; \
	fi
	cd public-inbox && $(CONTAINER)-compose up -d && $(CONTAINER)-compose logs -f

.PHONY: serve-off
serve-off:
	cd public-inbox && $(CONTAINER)-compose down -v


