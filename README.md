# Symfony + Nginx + MySQL + Traefik (Local Dev Stack)

This repository provides a local containerized stack for a Symfony app behind a shared Traefik reverse proxy, with MySQL and phpMyAdmin.

## What Is Included

- Traefik (shared edge proxy)
- Nginx (HTTP server)
- PHP-FPM (custom image with Xdebug config)
- MySQL 8.0
- phpMyAdmin

## Prerequisites

- Docker Engine (or Docker Desktop)
- Docker Compose v2 (`docker compose`)
- GNU Make (`make`)
- Free local ports: `80`, `443`, `8080`

## Routing And Hostnames

Traefik routes requests using Docker labels defined in `skeleton/compose.yaml`.
Host prefixes come from `skeleton/.env`:

- `HOST="group1"` -> app URL: `https://group1.example.test`
- `PMA_HOST="pma-group1"` -> phpMyAdmin URL: `https://pma-group1.example.test`

Add these hostnames in your local hosts file (for example `/etc/hosts`) to point to `127.0.0.1`.

## Networks

- `proxy-net` (external/shared): used by Traefik and exposed services.
- `internal_network_groups1`: private network for app-internal communication.

## Compose Files

- `infra/traefik.yaml`
  - Starts Traefik on ports `80`, `443`, and dashboard `8080`.
  - Redirects HTTP to HTTPS.
  - Uses Docker provider with `exposedByDefault=false`.

- `skeleton/compose.yaml`
  - App services: `nginx`, `php`, `database`, `phpmyadmin`.
  - Traefik-exposed services: `nginx`, `phpmyadmin`.
  - Internal-only services: `php`, `database`.

## Environment Variables (skeleton/.env)

- `HOST`
- `PMA_HOST`
- `DATABASE_NAME`
- `DTABASE_ROOT_PASSWORD` (kept as-is to match current compose variable name)

## Make Commands

### From repository root

- `make init`
  - Creates shared network `proxy-net`.

- `make start-traefik`
  - Starts Traefik from `infra/traefik.yaml`.

- `make stop`
  - Stops all running Docker containers (`docker stop $(docker ps -aq)`).

- `make kill`
  - Runs `make stop`, then prunes Docker system, networks, and volumes.

### From `skeleton/`

- `make start` -> `docker compose up -d --no-recreate --remove-orphans`
- `make down` -> `docker compose down --remove-orphans`
- `make stop` -> `docker compose stop`
- `make build` -> `docker compose build --no-cache --force-rm`
- `make install` -> composer install in `php` container
- `make enter` -> shell in `php` container
- `make info` -> PHP version in `php` container
- `make list` -> container status

## Quick Start

1. From repository root: `make init`
2. From repository root: `make start-traefik`
3. From `skeleton/`: `make build && make start`
4. Open:
   - `https://group1.example.test`
   - `https://pma-group1.example.test`
   - Traefik dashboard: `http://localhost:8080`
