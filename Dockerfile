FROM debian:bookworm-slim

HEALTHCHECK NONE

ENTRYPOINT []

ARG USER_NAME=verilator
ARG USER_HOME=/home/verilator
ARG USER_ID=1000

RUN apt-get update && \
  apt-get install --no-install-recommends -y verilator build-essential lcov git cmake ninja-build ca-certificates libz-dev python3 virtualenv && \
  # Removing documentation packages *after* installing them is kind of hacky,
  # but it only adds some overhead while building the image.
  apt-get --purge remove -y .\*-doc$ && \
  # Remove more unnecessary stuff
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

RUN adduser \
  --home "${USER_HOME}" \
  --uid "${USER_ID}" \
  --disabled-password \
  "${USER_NAME}"

ENV HOME "${USER_HOME}"

USER "${USER_NAME}"

WORKDIR "${HOME}"a
