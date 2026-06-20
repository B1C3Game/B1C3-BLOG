Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$indexPath = Join-Path $root "INDEX.md"

$exclude = @("_template", "_tools")
$dirs = Get-ChildItem -Path $root -Directory | Where-Object { $exclude -notcontains $_.Name } | Sort-Object Name

$lines = @()
$lines += "# NSFW Meme Index"
$lines += ""
$lines += "Generated: $((Get-Date).ToString('yyyy-MM-dd HH:mm:ss'))"
$lines += ""
$lines += "## Meme Folders"
$lines += ""

foreach ($dir in $dirs) {
  $metaPath = Join-Path $dir.FullName "metadata.json"
  $title = $dir.Name
  if (Test-Path $metaPath) {
    try {
      $meta = Get-Content -Raw -Path $metaPath | ConvertFrom-Json
      if ($meta.title) {
        $title = [string]$meta.title
      }
    } catch {
      # keep folder name as title fallback
    }
  }

  $lines += "- $title ($($dir.Name))"
}

$lines += ""
$lines += "## Conventions"
$lines += ""
$lines += "- Each meme folder must include PROMPT_CHATGPT.md, MEME_CARD.md, metadata.json, assets/, exports/."
$lines += "- Keep prompts reproducible and meme meaning self-explanatory."

Set-Content -Path $indexPath -Value ($lines -join [Environment]::NewLine) -Encoding UTF8
Write-Host "Updated index: $indexPath"
Write-Host "Total meme folders: $($dirs.Count)"
