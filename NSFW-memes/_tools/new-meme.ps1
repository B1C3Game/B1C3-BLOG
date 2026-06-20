param(
  [Parameter(Mandatory = $true)]
  [string]$Name,
  [string]$Title = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$templateDir = Join-Path $root "_template"

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant()
  $slug = [regex]::Replace($slug, "[^a-z0-9]+", "-")
  $slug = $slug.Trim("-")
  if ([string]::IsNullOrWhiteSpace($slug)) {
    throw "Could not generate a valid slug from Name."
  }
  return $slug
}

function New-FromTemplate {
  param(
    [string]$TemplatePath,
    [string]$DestinationPath,
    [string]$Slug,
    [string]$ResolvedTitle,
    [string]$DateStamp
  )

  $content = Get-Content -Raw -Path $TemplatePath
  $content = $content.Replace("{{SLUG}}", $Slug)
  $content = $content.Replace("{{TITLE}}", $ResolvedTitle)
  $content = $content.Replace("{{DATE}}", $DateStamp)
  Set-Content -Path $DestinationPath -Value $content -Encoding UTF8
}

$slug = Convert-ToSlug -Value $Name
$resolvedTitle = if ([string]::IsNullOrWhiteSpace($Title)) { $Name } else { $Title }
$dateStamp = (Get-Date).ToString("yyyy-MM-dd")

$memeDir = Join-Path $root $slug
if (Test-Path $memeDir) {
  throw "Folder already exists: $memeDir"
}

New-Item -ItemType Directory -Path $memeDir | Out-Null
New-Item -ItemType Directory -Path (Join-Path $memeDir "assets") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $memeDir "exports") | Out-Null

New-FromTemplate -TemplatePath (Join-Path $templateDir "PROMPT_CHATGPT.md") -DestinationPath (Join-Path $memeDir "PROMPT_CHATGPT.md") -Slug $slug -ResolvedTitle $resolvedTitle -DateStamp $dateStamp
New-FromTemplate -TemplatePath (Join-Path $templateDir "MEME_CARD.md") -DestinationPath (Join-Path $memeDir "MEME_CARD.md") -Slug $slug -ResolvedTitle $resolvedTitle -DateStamp $dateStamp
New-FromTemplate -TemplatePath (Join-Path $templateDir "metadata.json") -DestinationPath (Join-Path $memeDir "metadata.json") -Slug $slug -ResolvedTitle $resolvedTitle -DateStamp $dateStamp

Write-Host "Created meme scaffold: $slug"
Write-Host "Path: $memeDir"
