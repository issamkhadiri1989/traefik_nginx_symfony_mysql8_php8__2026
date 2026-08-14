# Microservices Angular + Symfony + Traefik (Local Dev Stack)

This repository provides a local containerized stack for Symfony-based services behind a shared Traefik reverse proxy, with MySQL and phpMyAdmin included.

## Prerequisites

Before running the app, make sure you have:

- Docker Engine (or Docker Desktop)
- Docker Compose v2 (`docker compose`)
- GNU Make (`make`)
- Free local ports: `80`, `443`, and `8080`

Also ensure local DNS resolution for your service domains (for example in `/etc/hosts`):

- `group2.example.test`
- `pma-group2.example.test`

These hostnames come from `skeleton/.env`:

- `HOST` -> app domain prefix
- `PMA_HOST` -> phpMyAdmin domain prefix

## Stack Used (and Why)

- **Traefik**: edge reverse proxy and router.
  - Why: dynamically discovers Docker services through labels, centralizes routing, and terminates HTTPS for all local services.

- **Nginx**: web server in front of PHP.
  - Why: serves static files efficiently and forwards PHP requests to PHP-FPM.

- **PHP-FPM (custom PHP image)**: runtime for Symfony/PHP code.
  - Why: isolates PHP dependencies/config, supports development tooling (including Xdebug config in this repo).

- **MySQL 8.0**: relational database.
  - Why: persistent SQL storage for the application.

- **phpMyAdmin**: database administration UI.
  - Why: quick visual access to inspect/manage MySQL data during development.

- **Docker Networks**:
  - `proxy-net` (external/shared)
  - `internal_network_groups1` (service-private)
  - Why: separates internal traffic from edge/proxy traffic while allowing Traefik to reach only exposed services.

## Compose Files

- `infra/traefik.yaml`: runs the shared Traefik proxy (ports `80`, `443`, `8080`).
- `skeleton/compose.yaml`: runs app services (`nginx`, `php`, `database`, `phpmyadmin`) and connects them to Traefik via labels.

## Make Commands

### From repository root

- `make init`  
  Create the shared Docker network `proxy-net`.

- `make start-traefik`  
  Start Traefik using `infra/traefik.yaml`.

- `make stop`  
  Stop all running containers.

- `make kill`  
  Stop containers and prune Docker resources (system, networks, volumes).

### From `skeleton/`

- `make start`  
  Start project services in detached mode.

- `make down`  
  Stop and remove project containers.

- `make stop`  
  Stop project containers without removing them.

- `make build`  
  Rebuild images with no cache.

- `make install`  
  Run Composer install in the PHP container.

- `make enter`  
  Open a shell inside the PHP container.

- `make info`  
  Show PHP version from the PHP container.

- `make list`  
  List project containers and status.

## Quick Start

1. From repo root: `make init`
2. From repo root: `make start-traefik`
3. From `skeleton/`: `make build && make start`
4. Open:
   - `https://group2.example.test`
   - `https://pma-group2.example.test`
   - Traefik dashboard: `http://localhost:8080`
