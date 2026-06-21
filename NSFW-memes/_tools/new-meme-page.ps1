param(
  [Parameter(Mandatory = $true)]
  [string]$Slug,
  [string]$PageSlug = "",
  [string]$Title = "",
  [string]$Lead = "",
  [string]$AltText = "",
  [string]$Definition = "",
  [string]$WhenToUse = "",
  [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$nsfwMemesRoot = Split-Path -Parent $PSScriptRoot
$blogRoot = Split-Path -Parent $nsfwMemesRoot
$memeSourceDir = Join-Path $nsfwMemesRoot $Slug
$pagesDir = Join-Path $blogRoot "nsfw\memes"

function Convert-ToSlug {
  param([string]$Value)
  $slug = $Value.ToLowerInvariant()
  $slug = [regex]::Replace($slug, "[^a-z0-9]+", "-")
  $slug = $slug.Trim("-")
  if ([string]::IsNullOrWhiteSpace($slug)) {
    throw "Could not create a valid slug from value: $Value"
  }
  return $slug
}

function Convert-ToTitle {
  param([string]$Value)
  $parts = $Value -split "-" | Where-Object { $_.Length -gt 0 }
  $words = foreach ($part in $parts) {
    if ($part.Length -eq 1) {
      $part.ToUpperInvariant()
    } else {
      $part.Substring(0, 1).ToUpperInvariant() + $part.Substring(1)
    }
  }
  return ($words -join " ")
}

if (-not (Test-Path $memeSourceDir)) {
  throw "Meme source folder not found: $memeSourceDir"
}

$metaPath = Join-Path $memeSourceDir "metadata.json"
$meta = $null
if (Test-Path $metaPath) {
  $meta = Get-Content -Raw -Path $metaPath | ConvertFrom-Json
}

$resolvedPageSlug = if ([string]::IsNullOrWhiteSpace($PageSlug)) {
  $base = $Slug
  $base = [regex]::Replace($base, "-[0-9a-f]{8}(?:-[0-9a-f]{4}){3}-[0-9a-f]{12}(?:-\d+)?$", "")
  Convert-ToSlug -Value $base
} else {
  Convert-ToSlug -Value $PageSlug
}

$resolvedTitle = $Title
if ([string]::IsNullOrWhiteSpace($resolvedTitle)) {
  if ($meta -and -not [string]::IsNullOrWhiteSpace([string]$meta.title)) {
    $resolvedTitle = [string]$meta.title
  } else {
    $resolvedTitle = Convert-ToTitle -Value $resolvedPageSlug
  }
}

$imageCandidates = @(
  "assets\original.png",
  "assets\original.jpg",
  "assets\original.jpeg",
  "assets\original.webp"
)

$selectedImage = $null
foreach ($candidate in $imageCandidates) {
  $candidatePath = Join-Path $memeSourceDir $candidate
  if (Test-Path $candidatePath) {
    $selectedImage = $candidate.Replace("\", "/")
    break
  }
}

if ($null -eq $selectedImage) {
  $assetsDir = Join-Path $memeSourceDir "assets"
  if (Test-Path $assetsDir) {
    $fallbackImage = Get-ChildItem -Path $assetsDir -File | Where-Object {
      @(".png", ".jpg", ".jpeg", ".webp") -contains $_.Extension.ToLowerInvariant()
    } | Select-Object -First 1

    if ($fallbackImage) {
      $selectedImage = ("assets/{0}" -f $fallbackImage.Name)
    }
  }
}

if ($null -eq $selectedImage) {
  throw "No source image found. Expected assets/original.* or any image file in assets/ for $memeSourceDir"
}

$resolvedLead = if ([string]::IsNullOrWhiteSpace($Lead)) {
  "NSFW meme entry for $resolvedTitle."
} else {
  $Lead
}

$resolvedAltText = if ([string]::IsNullOrWhiteSpace($AltText)) {
  "Primary image for $resolvedTitle"
} else {
  $AltText
}

$resolvedDefinition = if ([string]::IsNullOrWhiteSpace($Definition)) {
  "See MEME_CARD for full framing and usage context."
} else {
  $Definition
}

$resolvedWhenToUse = if ([string]::IsNullOrWhiteSpace($WhenToUse)) {
  "Use this meme when the same pattern appears and you need concise framing with reproducible prompt context."
} else {
  $WhenToUse
}

if (-not (Test-Path $pagesDir)) {
  New-Item -ItemType Directory -Path $pagesDir | Out-Null
}

$pagePath = Join-Path $pagesDir ("{0}.html" -f $resolvedPageSlug)
if ((Test-Path $pagePath) -and (-not $Force.IsPresent)) {
  throw "Page already exists: $pagePath. Use -Force to overwrite."
}

$metaDescription = "{0} meme entry in B1C3 NSFW." -f $resolvedTitle
$imageRelativePath = "../../NSFW-memes/{0}/{1}" -f $Slug, $selectedImage
$promptRelativePath = "../../NSFW-memes/{0}/PROMPT_CHATGPT.md" -f $Slug
$cardRelativePath = "../../NSFW-memes/{0}/MEME_CARD.md" -f $Slug
$metaRelativePath = "../../NSFW-memes/{0}/metadata.json" -f $Slug

$encodedTitle = [System.Net.WebUtility]::HtmlEncode($resolvedTitle)
$encodedDescription = [System.Net.WebUtility]::HtmlEncode($metaDescription)
$encodedLead = [System.Net.WebUtility]::HtmlEncode($resolvedLead)
$encodedAltText = [System.Net.WebUtility]::HtmlEncode($resolvedAltText)
$encodedDefinition = [System.Net.WebUtility]::HtmlEncode($resolvedDefinition)
$encodedWhenToUse = [System.Net.WebUtility]::HtmlEncode($resolvedWhenToUse)

$html = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$encodedTitle | B1C3 NSFW</title>
  <meta name="description" content="$encodedDescription">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;700&family=JetBrains+Mono:wght@500&family=Libre+Baskerville:wght@700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../../css/style.css">
  <link rel="stylesheet" href="../../css/responsive.css">
  <link rel="icon" href="../../static/favicon.svg" type="image/svg+xml">
  <script defer src="../../js/nsfw-gate.js"></script>
</head>
<body>
  <div class="atmosphere" aria-hidden="true"></div>

  <header class="site-header">
    <a class="brand" href="../../index.html" aria-label="B1C3 Blog Home">B1C3</a>
    <nav aria-label="Primary">
      <a href="../../index.html">Blog</a>
      <a href="../index.html" aria-current="page">NSFW</a>
      <a href="https://b1c3game.github.io/B1C3-LANDING/" target="_blank" rel="noreferrer">Home</a>
      <a href="https://github.com/B1C3Game/B1C3-BLOG" target="_blank" rel="noreferrer">GitHub</a>
    </nav>
  </header>

  <main>
    <section id="nsfw-content" class="panel reveal nsfw-content" hidden>
      <p class="eyebrow">Candidate meme entry</p>
      <h1>$encodedTitle</h1>
      <p class="lead">$encodedLead</p>

      <figure class="post-image">
        <img src="$imageRelativePath" alt="$encodedAltText" loading="lazy">
        <figcaption>Primary source render from NSFW-memes/$Slug.</figcaption>
      </figure>

      <article class="card">
        <h2>Definition</h2>
        <p>$encodedDefinition</p>
      </article>

      <article class="card">
        <h2>When To Use</h2>
        <p>$encodedWhenToUse</p>
      </article>

      <article class="card">
        <h2>Build Files</h2>
        <p><a href="$promptRelativePath">Prompt pack</a> | <a href="$cardRelativePath">Meme card</a> | <a href="$metaRelativePath">Metadata</a></p>
      </article>

      <p><a class="button ghost" href="../index.html">Back to NSFW hub</a></p>
    </section>
  </main>

  <footer class="site-footer reveal">
    <p class="micro">B1C3 NSFW lab, explicit consent, reversible choices.</p>
  </footer>
</body>
</html>
"@

Set-Content -Path $pagePath -Value $html -Encoding UTF8

Write-Host "Created meme page: $resolvedPageSlug"
Write-Host "Path: $pagePath"
Write-Host "Source slug: $Slug"
