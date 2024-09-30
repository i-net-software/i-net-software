FROM alpine:latest

# Install strongSwan and dependencies
RUN apk add --no-cache \
  strongswan \
  iproute2 \
  iputils \
  && rm -rf /var/cache/apk/*

# Create a non-root user and group
RUN addgroup -S strongswan && adduser -S strongswan -G strongswan

# Create the configuration directory
RUN mkdir -p /srv/strongswan /srv/strongswan/ipsec.d /var/log && \
    chown -R strongswan:strongswan /srv/strongswan /srv/strongswan/ipsec.d /var/log

# Copy configuration files to /srv/strongswan
# COPY ipsec.conf /srv/strongswan/ipsec.conf
# COPY ipsec.secrets /srv/strongswan/ipsec.secrets
# COPY strongswan.conf /srv/strongswan/strongswan.conf

# Set permissions for the configuration files
RUN chown -R strongswan:strongswan /srv/strongswan

# Switch to the non-root user
USER strongswan

# Start strongSwan with the correct configuration path
CMD ["ipsec", "start", "--nofork", "--confdir", "/srv/strongswan"]
