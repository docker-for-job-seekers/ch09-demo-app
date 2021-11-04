#!/usr/bin/env sh

echo "Removing api container if it exists..."
docker container rm -f web || true

echo "Removing network test-net if it exists..."
docker network rm test-net || true

echo "Deploying app ($registry:$BUILD_NUMBER)..."
docker network create test-net
docker container run -d \
    -p 3000:3000 \
    --name web \
    --net test-net \
    $registry:$BUILD_NUMBER

# defining logic to wait for the WEB component to be ready on port 3000
read -d '' wait_for << EOF
    echo "Waiting for WEB to listen on port 3000..."
    while ! nc -z web 3000; do
        sleep 0.3 # wait for 3/10 of the second before check again
        printf "."
    done
    echo "Web ready on port 3000!"
EOF

# using the above logic from within an Alpine container
docker container run --rm \
    --net test-net \
    node:12.10-alpine sh -c "$wait_for"

