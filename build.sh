BUILD_GOOS=${GOOS:-$(go env GOOS)}
BUILD_GOARCH=${GOARCH:-$(go env GOARCH)}
GOBINARY=${GOBINARY:-go}

${GOBINARY} mod vendor

# forgoing -i (incremental build) because it will be deprecated by tool chain.
GOOS=${BUILD_GOOS} CGO_ENABLED=0 GOARCH=${BUILD_GOARCH} ${GOBINARY} build \
        -o /usr/local/bin/server \
        http3.go