Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$templateDir = Join-Path $root "_template"
$dateStamp = (Get-Date).ToString("yyyy-MM-dd")

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant()
  $slug = [regex]::Replace($slug, "[^a-z0-9]+", "-")
  $slug = $slug.Trim("-")
  if ([string]::IsNullOrWhiteSpace($slug)) {
    $slug = "meme"
  }
  return $slug
}

function Resolve-UniqueFolder {
  param(
    [string]$Parent,
    [string]$BaseSlug
  )

  $candidate = Join-Path $Parent $BaseSlug
  if (-not (Test-Path $candidate)) {
    return $candidate
  }

  $i = 2
  while ($true) {
    $next = Join-Path $Parent ("{0}-{1}" -f $BaseSlug, $i)
    if (-not (Test-Path $next)) {
      return $next
    }
    $i++
  }
}

function New-FromTemplate {
  param(
    [string]$TemplatePath,
    [string]$DestinationPath,
    [string]$Slug,
    [string]$Title,
    [string]$DateStamp
  )

  $content = Get-Content -Raw -Path $TemplatePath
  $content = $content.Replace("{{SLUG}}", $Slug)
  $content = $content.Replace("{{TITLE}}", $Title)
  $content = $content.Replace("{{DATE}}", $DateStamp)
  Set-Content -Path $DestinationPath -Value $content -Encoding UTF8
}

$allowed = @(".png", ".jpg", ".jpeg", ".webp")
$looseFiles = Get-ChildItem -Path $root -File | Where-Object { $allowed -contains $_.Extension.ToLowerInvariant() }

if (-not $looseFiles) {
  Write-Host "No loose image files found in $root"
  exit 0
}

$imported = 0
foreach ($file in $looseFiles) {
  $baseSlug = Convert-ToSlug -Value $file.BaseName
  $memeDir = Resolve-UniqueFolder -Parent $root -BaseSlug $baseSlug
  $slug = Split-Path -Leaf $memeDir
  $title = ($slug -split "-") | ForEach-Object {
    if ($_.Length -gt 0) {
      $_.Substring(0,1).ToUpperInvariant() + $_.Substring(1)
    }
  }
  $title = ($title -join " ")

  New-Item -ItemType Directory -Path $memeDir | Out-Null
  $assetsDir = Join-Path $memeDir "assets"
  $exportsDir = Join-Path $memeDir "exports"
  New-Item -ItemType Directory -Path $assetsDir | Out-Null
  New-Item -ItemType Directory -Path $exportsDir | Out-Null

  $originalName = "original{0}" -f $file.Extension.ToLowerInvariant()
  $destinationAsset = Join-Path $assetsDir $originalName
  Move-Item -Path $file.FullName -Destination $destinationAsset

  New-FromTemplate -TemplatePath (Join-Path $templateDir "PROMPT_CHATGPT.md") -DestinationPath (Join-Path $memeDir "PROMPT_CHATGPT.md") -Slug $slug -Title $title -DateStamp $dateStamp
  New-FromTemplate -TemplatePath (Join-Path $templateDir "MEME_CARD.md") -DestinationPath (Join-Path $memeDir "MEME_CARD.md") -Slug $slug -Title $title -DateStamp $dateStamp
  New-FromTemplate -TemplatePath (Join-Path $templateDir "metadata.json") -DestinationPath (Join-Path $memeDir "metadata.json") -Slug $slug -Title $title -DateStamp $dateStamp

  Write-Host "Imported: $($file.Name) -> $slug"
  $imported++
}

Write-Host "Done. Imported $imported file(s)."
