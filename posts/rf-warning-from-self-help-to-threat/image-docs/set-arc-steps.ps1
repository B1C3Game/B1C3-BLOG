Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$baseDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$map = @{
  "rf-warning-01-steelman-baseline" = "1"
  "rf-warning-02-jester-recursion" = "2"
  "rf-warning-03-courage-ladder-precursor" = "3"
  "rf-warning-04b-first-mover-tarot" = "4"
  "rf-warning-04c-birth-by-fire-warning-book" = "4b"
  "rf-warning-04d-late-entry-performance-notice" = "4c"
  "rf-warning-03-classified-handoff" = "4d"
  "rf-warning-04e-doctrine-decision-architecture" = "4e"
  "rf-warning-05a-kernel-doctrine-8e65" = "5"
  "rf-warning-05b-kernel-doctrine-safety-notice-v2" = "5b"
  "rf-warning-06-self-help-outlier" = "6"
  "rf-warning-07-public-signal-review" = "7"
  "rf-warning-08-diagnosis-journal" = "8"
  "rf-warning-09-implementation-review-get-it" = "9"
  "rf-warning-10-poe1-righteous-fire-origin" = "10"
}

$updated = 0
Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -ne "_template" } | ForEach-Object {
  $metaPath = Join-Path $_.FullName "metadata.json"
  if (-not (Test-Path $metaPath)) { return }

  $json = Get-Content -Path $metaPath -Raw | ConvertFrom-Json
  if ($map.ContainsKey($_.Name)) {
    $json.arc_step = $map[$_.Name]
    $json | ConvertTo-Json -Depth 5 | Set-Content -Path $metaPath -Encoding UTF8
    $updated++
  }
}

Write-Output "Updated arc_step in $updated metadata files."
