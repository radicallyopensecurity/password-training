FROM ruby:2.7.5-alpine AS builder
LABEL maintainer="Beef Project: github.com/beefproject/beef"

# Install gems in parallel with 4 workers to expedite build process.=
ARG BUNDLER_ARGS="--jobs=4"
ARG VERSION=v0.5.4.0

# Set gemrc config to install gems without Ruby Index (ri) and Ruby Documentation (rdoc) files
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

WORKDIR /beef

RUN wget -q https://github.com/beefproject/beef/archive/refs/tags/${VERSION}.tar.gz -O /tmp/beef.tgz \
  && tar -xzf /tmp/beef.tgz --strip 1 -C /beef

# Add bundler/gem dependencies and then install
RUN apk add --no-cache git curl libcurl curl-dev ruby-dev libffi-dev make g++ gcc musl-dev zlib-dev sqlite-dev && \
  bundle install --gemfile=/beef/Gemfile $BUNDLER_ARGS && \
  # Temp fix for https://github.com/bundler/bundler/issues/6680
  rm -rf /usr/local/bundle/cache



# So we don't need to run as root
RUN chmod -R a+r /usr/local/bundle

FROM ruby:2.7.5-alpine
LABEL maintainer="Beef Project: github.com/beefproject/beef"

# Create service account to run BeEF
RUN adduser -h /beef -g beef -D beef

COPY --from=builder --chown=1000:1000 /beef /beef

# Use gemset created by the builder above
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Install BeEF's runtime dependencies
RUN apk add --no-cache curl git build-base openssl readline-dev zlib zlib-dev libressl-dev yaml-dev sqlite-dev sqlite libxml2-dev libxslt-dev autoconf libc6-compat ncurses automake libtool bison nodejs

WORKDIR /beef


# Ensure we are using our service account by default
USER beef

# Expose UI, Proxy, WebSocket server, and WebSocketSecure server
EXPOSE 3000 6789 61985 61986

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "curl", "-fS", "localhost:3000" ]

ENTRYPOINT ["/beef/beef"]
# ------------------------------------- End of Builder 1 -------------------------------------------------
