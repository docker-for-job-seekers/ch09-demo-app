#!/usr/bin/env sh
echo "Smoke tests..."
docker container run --name tester \
    --rm \
    --net test-net \
    dockerforjobseekers/node-docker sh -c "curl web:3000"