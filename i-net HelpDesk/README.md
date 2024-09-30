# i-net HelpDesk

The [i-net HelpDesk](https://www.inetsoftware.de/de/products/helpdesk) is a service management software.

Here, you can find a `docker-compose.yml` to start the i-net HelpDesk Server with a sidecar MySQL database. The `cloud-init.yml` contains a standard setup that can be used with supported providers, such as Hetzner Cloud.

## Backup using duply

The system comes pre-configured with duply. You have to either create a new GPG key or import your existing one to make use of the backup encryption. You can have a look https://www.thomas-krenn.com/en/wiki/Backup_on_Linux_with_duply for additional information.

## Running an ensemble with VPN

You have to prepare the Strongswan configuration in `/srv/strongswan`:

```
mkdir -p /srv/strongswan
cp -a ./strongswan/strongswan.conf /srv/strongswan/
cat > /srv/strongswan/ipsec.conf
# Content
# STRG+C

cat > /srv/strongswan/ipsec.secret
# Content
# STRG+C
```

```bash

export COMPOSE_OPT="-f docker-compose-vpn.yml"
docker compose ${COMPOSE_OPT} build strongswan
read -p "Enter IP address: " IP_END_POINT; IP_SUB_NET=$(ipcalc -n -b $IP_END_POINT 28 | grep Network | awk '{print $2}'); export IP_SUB_NET IP_END_POINT;

docker compose ${COMPOSE_OPT} config
docker compose ${COMPOSE_OPT} up -d
```
