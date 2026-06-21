Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$baseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$postDir = Split-Path -Parent $baseDir
$imagesDir = Join-Path $postDir "images"

$images = Get-ChildItem -Path $imagesDir -File -Filter "*.png" | Sort-Object Name

foreach ($img in $images) {
  $slug = [System.IO.Path]::GetFileNameWithoutExtension($img.Name)
  $titleWords = ($slug -split "-") | Where-Object { $_.Length -gt 0 } | ForEach-Object {
    if ($_.Length -eq 1) { $_.ToUpperInvariant() } else { $_.Substring(0,1).ToUpperInvariant() + $_.Substring(1) }
  }
  $titleText = $titleWords -join " "

  $dir = Join-Path $baseDir $slug
  New-Item -ItemType Directory -Path $dir -Force | Out-Null

  $promptSource = @"
# Prompt Source - $slug

## Intent

RF-warning arc image for step mapping and doctrine stress-test presentation.

## Prompt Core

Original prompt chain for this image should be recorded here when available.

Source link: TBA

## Constraints

- No copyrighted characters or logos.
- Keep warning framing legible.
- Preserve doctrine-over-aesthetic priority.

## Variant Notes

Part of RF-warning sequence. See ASSET-MAP and image-docs/INDEX.md for arc placement.
"@

  $imageCard = @"
# Image Card - $titleText

## One-line Definition

RF-warning doctrine image in the sequence from self-help framing to threat-aware consequence logic.

## Interpretation

This artifact contributes to the progression from aesthetic satire toward operational warning semantics.

## When To Use

- Explaining the RF-warning arc and method progression.
- Showing how warning framing changes perceived seriousness.

## Misread Risk

Risk: read as style-only satire. Correction: this is part of a consequence-focused doctrine sequence.
"@

  $metadata = @"
{
  "slug": "$slug",
  "title": "$titleText",
  "status": "reviewed",
  "post_path": "posts/rf-warning-from-self-help-to-threat.html",
  "static_image_path": "static/images/$($img.Name)",
  "arc_step": "",
  "prompt_source_link": "TBA",
  "notes": "Auto-seeded documentation entry; refine with exact prompt provenance."
}
"@

  Set-Content -Path (Join-Path $dir "PROMPT_SOURCE.md") -Value $promptSource -Encoding UTF8
  Set-Content -Path (Join-Path $dir "IMAGE_CARD.md") -Value $imageCard -Encoding UTF8
  Set-Content -Path (Join-Path $dir "metadata.json") -Value $metadata -Encoding UTF8
}

Write-Output "Seeded docs for $($images.Count) RF-warning images."
