# How to publish this folder (do not commit this file)

This folder is a ready-to-push copy of the PUBLIC `bakup-releases` repo.
The private code repo stays private; only this content goes public.

## 1. Create the public repo & push
```bash
cd release-repo
git init && git add README.md LICENSE logo.png docs/ dockerhub-overview.md
git commit -m "bakup public releases + website"
git branch -M main
git remote add origin https://github.com/kobraop9517/bakup-releases.git
git push -u origin main
```
(Note: `release-assets/` and this PUBLISH.md are NOT committed — assets are
uploaded to the GitHub Release instead, see step 3.)

## 2. Enable the website
GitHub → bakup-releases → Settings → Pages → Source: `main` branch, `/docs` folder.
Site appears at https://kobraop9517.github.io/bakup-releases/

## 3. Create release v0.1.0 and upload the assets
GitHub → bakup-releases → Releases → "Draft a new release" → tag `v0.1.0`.
Attach everything in `release-assets/`:
- bakup_0.1.0_all.deb
- bakup-0.1.0-py3-none-any.whl
- install.ps1
- docker-compose.yml
- bakup-setup-0.1.0.exe   <- build this on Windows first:
    powershell -File packaging\windows\build-exe.ps1   (in the private repo)
    then compile packaging\windows\bakup-setup.iss with Inno Setup

## 4. Docker Hub
- Push the image (from the private repo): docker build -t kobraop9517/backup:v1.1 -t kobraop9517/backup:latest ./server && docker push kobraop9517/backup --all-tags
- Paste `dockerhub-overview.md` into the Docker Hub repo's Overview tab.

## 5. Sanity check as a stranger
- Open the website, click through the guide
- curl the docker-compose.yml release URL, `docker compose up -d`, check logs for token
- Install the client from a release URL on a machine without the code
