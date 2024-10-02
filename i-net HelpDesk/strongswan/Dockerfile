FROM alpine:latest

# Install strongSwan and dependencies
RUN apk add --no-cache \
  strongswan \
  iproute2 \
  iputils \
  && rm -rf /var/cache/apk/*

# Copy configuration files to /etc
# COPY ipsec.conf /etc/ipsec.conf
# COPY ipsec.secrets /etc/ipsec.secrets
# COPY strongswan.conf /etc/strongswan.conf

# Start strongSwan with the correct configuration path
CMD ["ipsec", "start", "--nofork"]
