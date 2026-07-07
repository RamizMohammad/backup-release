<p align="center"><img src="logo.png" width="110" alt="bakup"></p>

<h1 align="center">bakup — backup like you git</h1>

<p align="center">Self-hosted, git-like backup. Commit offline, push when you're home.<br>
Content-addressed &amp; deduplicated. Your files, your server, your rules.</p>

<p align="center"><b><a href="https://kobraop9517.github.io/bakup-releases/">Website &amp; interactive setup guide</a></b> ·
<a href="https://github.com/kobraop9517/bakup-releases/releases/latest">Downloads</a> ·
<a href="https://hub.docker.com/r/kobraop9517/backup">Docker Hub</a></p>

---

## Server (any machine with Docker)

```bash
mkdir bakup-server && cd bakup-server
curl -LO https://github.com/kobraop9517/bakup-releases/releases/latest/download/docker-compose.yml
docker compose up -d
docker compose logs bakup-server    # first run prints your access token — save it
```

## Client

| OS | Install |
|----|---------|
| Linux (Debian-family) | download `bakup_x.y.z_all.deb` from [releases](https://github.com/kobraop9517/bakup-releases/releases/latest) → `sudo apt install ./bakup_x.y.z_all.deb` |
| Windows (terminal) | `irm https://github.com/kobraop9517/bakup-releases/releases/latest/download/install.ps1 \| iex` |
| Windows (GUI) | download and run `bakup-setup-x.y.z.exe` from releases |
| macOS / any OS | `pipx install <wheel URL from releases>` (Python 3.9+) |

Then once per machine:

```bash
bakup config --server http://<server-ip>:8000 --token <TOKEN>
```

## Daily use

```bash
cd ~/my-project
bakup init                 # like git init
bakup commit -m "wip"      # snapshot locally — works offline
bakup push                 # upload when your server is reachable
bakup log                  # ✓ pushed / ○ local
bakup restore <commit_id> ./restore_here
```

> ⚠️ Keep the server on your LAN or behind a mesh VPN (Tailscale/WireGuard).
> Traffic is plain HTTP — don't expose port 8000 to the open internet.
> Commits store metadata only; content uploads at **push**, so push regularly.

## License

Free to use. See [LICENSE](LICENSE).
