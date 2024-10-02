FROM alpine:latest

# Install strongSwan and dependencies
RUN apk add --no-cache \
  strongswan \
  iproute2 \
  iputils \
  && rm -rf /var/cache/apk/*

# Create a non-root user and group
RUN addgroup -S strongswan && adduser -S strongswan -G strongswan

# Copy configuration files to /etc
# COPY ipsec.conf /etc/ipsec.conf
# COPY ipsec.secrets /etc/ipsec.secrets
# COPY strongswan.conf /etc/strongswan.conf

# Switch to the non-root user
USER strongswan

# Start strongSwan with the correct configuration path
CMD ["ipsec", "start", "--nofork"]
