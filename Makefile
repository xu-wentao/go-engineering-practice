.PHONY: fmt vet test check

fmt:
	gofmt -w $$(find . -name '*.go' -not -path './.git/*')

vet:
	go vet ./...

test:
	go test -race -cover ./...

check: fmt vet test
