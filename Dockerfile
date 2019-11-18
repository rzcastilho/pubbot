FROM elixir:1.9-alpine AS builder

ENV MIX_ENV=prod \
    LANG=C.UTF-8

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

COPY config ./config
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile
RUN mix release

FROM alpine:3.10 AS app

ENV LANG=C.UTF-8

RUN apk --no-cache update && \
    apk --no-cache upgrade && \
    apk --no-cache add ncurses-dev openssl-dev

WORKDIR /app
COPY templates ./templates
COPY --from=builder /app/_build .

ENTRYPOINT ["/app/prod/rel/pubbot/bin/pubbot"]

CMD ["start"]
