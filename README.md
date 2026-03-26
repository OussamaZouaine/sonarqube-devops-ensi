# SonarQube (Docker Compose)

This directory runs **SonarQube Community Edition (LTS)** with **PostgreSQL 17**. SonarQube requires an external database; the stack includes Postgres with health checks so SonarQube starts only after the DB is ready.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) (Compose V2: `docker compose`).

## Quick start

From this directory:

```bash
docker compose up -d
```

The first start can take a few minutes while SonarQube initializes.

## Access

| Item | Value |
|------|--------|
| **URL** | http://localhost:9000 |
| **Default login** | `admin` / `admin` |

You will be prompted to change the admin password on first login.

## What gets created

- **db** — `postgres:17-alpine`, database `sonar`, user/password `sonar` (used only between containers).
- **sonarqube** — built from the local `Dockerfile` (`sonarqube:lts-community` base), image tagged `local-sonarqube:lts-community`.

Named volumes persist data across restarts: `postgresql_data`, `sonarqube_data`, `sonarqube_extensions`, `sonarqube_logs`.

## Customizing the image

The `Dockerfile` extends the official LTS image. To add plugins, copy JARs into `/opt/sonarqube/extensions/plugins/` and set ownership for the `sonarqube` user as in the [SonarQube Docker docs](https://docs.sonarqube.org/latest/setup/install-server/).

## Useful commands

```bash
# View logs
docker compose logs -f sonarqube

# Stop (keeps volumes)
docker compose down

# Stop and remove volumes (full reset — loses SonarQube and DB data)
docker compose down -v
```

## Troubleshooting

- **SonarQube exits or fails to start on Linux/WSL2**: Elasticsearch (used by SonarQube) may need a higher `vm.max_map_count`. On the Docker host or WSL2, see [SonarQube requirements](https://docs.sonarqube.org/latest/requirements/requirements/) for the recommended value and how to set it.
- **Port 9000 in use**: Change the host port in `docker-compose.yml` (e.g. `"9001:9000"`) and open http://localhost:9001.
