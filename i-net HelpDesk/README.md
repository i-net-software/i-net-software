# i-net HelpDesk

The [i-net HelpDesk](https://www.inetsoftware.de/de/products/helpdesk) is a service management software.

Here, you can find a `docker-compose.yml` to start the i-net HelpDesk Server with a sidecar MySQL database. The `cloud-init.yml` contains a standard setup that can be used with supported providers, such as Hetzner Cloud.

## Backup using duply

The system comes pre-configured with duply. You have to either create a new GPG key or import your existing one to make use of the backup encryption. You can have a look https://www.thomas-krenn.com/en/wiki/Backup_on_Linux_with_duply for additional information.
