#!/usr/bin/env bash
set -e

[[ -z "${STREAMLINK_VERSION}" ]] && { echo 1>&2 "Missing STREAMLINK_VERSION"; exit 1; }

MANIFESTFILE=io.github.streamlink.streamlink.json
OUTPUT=python3-streamlink
DEPENDENCIES=(pip setuptools)

MANIFEST="$(cat "${MANIFESTFILE}")"
RUNTIME="$(jq -r '.sdk' <<< "${MANIFEST}")//$(jq -r '.["runtime-version"]' <<< "${MANIFEST}")"

pip3 install -U requirements-parser
python3 ./flatpak-builder-tools/pip/flatpak-pip-generator \
  --output "${OUTPUT}" \
  --runtime "${RUNTIME}" \
  "streamlink==${STREAMLINK_VERSION}" \
  "${DEPENDENCIES[@]}"
