.PHONY: check format

check:
	./scripts/check.sh

format:
	stylua .
