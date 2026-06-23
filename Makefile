.PHONY: fmt fmt-check vet test check

fmt:
	gofmt -w $$(find exercises -name '*.go')

fmt-check:
	@test -z "$$(gofmt -l $$(find exercises -name '*.go'))" || \
		(echo "The following files need gofmt:"; gofmt -l $$(find exercises -name '*.go'); exit 1)

vet:
	go vet ./exercises/...

test:
	go test -race -cover ./exercises/...

check: fmt-check vet test
