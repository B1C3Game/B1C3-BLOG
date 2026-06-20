param(
  [Parameter(Mandatory = $true)]
  [string]$Slug,
  [Parameter(Mandatory = $true)]
  [string]$OutputName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$repoRoot = Split-Path -Parent $root
$memeDir = Join-Path $root $Slug

if (-not (Test-Path $memeDir)) {
  throw "Meme folder not found: $memeDir"
}

$metaPath = Join-Path $memeDir "metadata.json"
if (-not (Test-Path $metaPath)) {
  throw "metadata.json missing for slug: $Slug"
}

$meta = Get-Content -Raw -Path $metaPath | ConvertFrom-Json
$selected = [string]$meta.selected_export
if ([string]::IsNullOrWhiteSpace($selected)) {
  throw "metadata.selected_export is empty for slug: $Slug"
}

$sourcePath = Join-Path $memeDir $selected
if (-not (Test-Path $sourcePath)) {
  throw "Selected export not found: $sourcePath"
}

$ext = [System.IO.Path]::GetExtension($sourcePath).ToLowerInvariant()
$allowed = @(".png", ".jpg", ".jpeg", ".webp")
if ($allowed -notcontains $ext) {
  throw "Unsupported extension '$ext'. Allowed: $($allowed -join ', ')"
}

$cleanBase = [regex]::Replace($OutputName.ToLowerInvariant(), "[^a-z0-9-]+", "-").Trim("-")
if ([string]::IsNullOrWhiteSpace($cleanBase)) {
  throw "OutputName produced empty filename. Use letters/numbers/dashes."
}

$destDir = Join-Path $repoRoot "static\images"
if (-not (Test-Path $destDir)) {
  New-Item -ItemType Directory -Path $destDir | Out-Null
}

$destPath = Join-Path $destDir ("nsfw-{0}{1}" -f $cleanBase, $ext)
Copy-Item -Path $sourcePath -Destination $destPath -Force

$meta.selected_export = $selected
$meta.status = "published"
$meta.notes = (([string]$meta.notes).Trim() + " Published to static/images as " + [System.IO.Path]::GetFileName($destPath)).Trim()

$meta | ConvertTo-Json -Depth 6 | Set-Content -Path $metaPath -Encoding UTF8

Write-Host "Published: $sourcePath"
Write-Host "To: $destPath"
