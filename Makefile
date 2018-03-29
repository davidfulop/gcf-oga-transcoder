build:
	@docker-compose build
.PHONY: build

test: cleanup build
	@docker-compose up
.PHONY: test

cleanup:
	@docker-compose down
.PHONY: cleanup
