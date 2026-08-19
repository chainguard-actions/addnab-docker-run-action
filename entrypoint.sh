#!/usr/bin/env bash

if [ ! -z "$INPUT_USERNAME" ];
then echo "$INPUT_PASSWORD" | docker login "$INPUT_REGISTRY" -u "$INPUT_USERNAME" --password-stdin
fi

echo "$INPUT_RUN" | sed -e 's/\\n/;/g' > semicolon_delimited_script

opts=()
if [ -n "$INPUT_OPTIONS" ]; then
  while IFS= read -r -d '' t; do opts+=("$t"); done \
    < <(printf '%s' "$INPUT_OPTIONS" | xargs printf '%s\0')
fi

exec docker run -v "/var/run/docker.sock":"/var/run/docker.sock" "${opts[@]}" --entrypoint "$INPUT_SHELL" "$INPUT_IMAGE" -c "$(cat semicolon_delimited_script)"
