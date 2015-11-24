# docker-dev-env
My  development environment based on Docker containers, used docker compose as a manager.

Docker and docker-compose have to be installed first.

Please fix configuration files first. Put valid generated SSL Cerificates into web/ssl directory.

In this configuration included 
- web: apache2 with SSL + PHP5.4 (include Phalcon2, XDebug, Net_GeoIp and required modules for another services)
- db: Percona
- Redis
- Mongo
- Solr 3.6
- Gearman
