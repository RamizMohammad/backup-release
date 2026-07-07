<p align="center">
  <img src="https://raw.githubusercontent.com/kobraop9517/bakup-releases/main/logo.png" width="128" alt="bakup">
</p>

# bakup-server

Self-hosted, **git-like backup** server. Clients `init` any folder, `commit`
snapshots offline, and `push` when this server is reachable. Content-addressed
and deduplicated by sha256 — identical files are stored once across all
clients and repos.

## Quick start (no configuration needed)

```bash
mkdir bakup-server && cd bakup-server
curl -LO https://github.com/kobraop9517/bakup-releases/releases/latest/download/docker-compose.yml
docker compose up -d
docker compose logs bakup-server    # first run prints your auto-generated access token
```

Or plain `docker run`:

```bash
docker run -d --name bakup-server --restart unless-stopped \
  -p 8000:8000 -v ./data:/data kobraop9517/backup:latest
docker logs bakup-server            # shows the access token
```

- Token is auto-generated on first run and saved in the volume
  (`docker exec bakup-server cat /data/.bakup_token`). Override with `-e BAKUP_TOKEN=...`
- Backups land in the `/data` volume — point it at a big disk
- Health endpoint: `GET /health`

## Get the client

Downloads (Linux .deb, Windows installer, Python wheel) and the full guide:
**https://github.com/kobraop9517/bakup-releases/releases/latest**

⚠️ Traffic is plain HTTP — keep the server on your LAN or behind a mesh VPN
(Tailscale/WireGuard); don't expose port 8000 to the open internet.
