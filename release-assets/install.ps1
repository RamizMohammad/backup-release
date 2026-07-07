# bakup — Windows terminal installer
# Run in PowerShell:
#   irm https://github.com/kobraop9517/bakup-releases/releases/latest/download/install.ps1 | iex
# or locally from a clone:  powershell -ExecutionPolicy Bypass -File packaging\windows\install.ps1

$ErrorActionPreference = "Stop"
# wheel from the PUBLIC releases repo — code itself stays private
$repo = "https://github.com/kobraop9517/bakup-releases/releases/latest/download/bakup-0.1.0-py3-none-any.whl"

Write-Host "== bakup installer ==" -ForegroundColor Cyan

# 1) ensure Python
$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py -or -not (python --version 2>$null)) {
    Write-Host "Python not found — installing via winget..."
    winget install --id Python.Python.3.12 -e --accept-source-agreements --accept-package-agreements
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [Environment]::GetEnvironmentVariable("Path", "User")
}
python --version

# 2) install bakup
python -m pip install --upgrade pip --quiet
python -m pip install --upgrade $repo

# 3) make sure the Scripts dir (where bakup.exe lands) is on PATH
$scripts = python -c "import sysconfig; print(sysconfig.get_path('scripts'))"
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$scripts*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$scripts", "User")
    $env:Path += ";$scripts"
    Write-Host "added $scripts to your PATH"
}

bakup --version
Write-Host ""
Write-Host "done! configure once, then use it anywhere:" -ForegroundColor Green
Write-Host "  bakup config --server http://<your-server>:80