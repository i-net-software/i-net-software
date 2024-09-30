# StrongSwan Docker Image

This is a simple StrongSwan Docker image that can be used to create simple connection to a VPN endpoint using IPsec.


```yaml
# Sample docker-compose.yml
services:
  strongswan:
    image: your-strongswan-image
    networks:
      my_network:
        ipv4_address: 172.172.0.2
    volumes:
      - ./strongswan:/srv/strongswan
    restart: always

  client:
    image: your-client-image
    networks:
      my_network:
        ipv4_address: 172.172.0.1
    depends_on:
      - strongswan
    restart: always

networks:
  my_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.172.0.0/24
```
