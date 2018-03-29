build:
	@docker-compose build
.PHONY: build

test: cleanup build
	@docker-compose up --abort-on-container-exit
.PHONY: test

cleanup:
	@docker-compose down
.PHONY: cleanup
