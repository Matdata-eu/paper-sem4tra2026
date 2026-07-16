param(
  [string]$Main = "paper",
  [string]$SourceDir = "source",
  [string]$DependencyDir = "dependencies",
  [string]$OutputDir = "output",
  [string]$Image = "cristiangreco/pdflatex",
  [switch]$Clean
)

$ErrorActionPreference = "Stop"

$root = (Get-Location).Path
$sourcePath = Join-Path $root $SourceDir
$dependencyPath = Join-Path $root $DependencyDir
$outputPath = Join-Path $root $OutputDir

New-Item -ItemType Directory -Force -Path $outputPath | Out-Null

if ($Clean) {
  Get-ChildItem -Path $outputPath -Filter "$Main.*" -File -ErrorAction SilentlyContinue |
    Remove-Item -Force -ErrorAction SilentlyContinue
}

$containerCommand = "cd /workspace/$SourceDir && env TEXINPUTS=.:../$DependencyDir//: BIBINPUTS=. pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$OutputDir $Main.tex && cd /workspace/$OutputDir && env BIBINPUTS=../$SourceDir bibtex $Main && cd /workspace/$SourceDir && env TEXINPUTS=.:../$DependencyDir//: BIBINPUTS=. pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$OutputDir $Main.tex && env TEXINPUTS=.:../$DependencyDir//: BIBINPUTS=. pdflatex -interaction=nonstopmode -halt-on-error -output-directory=../$OutputDir $Main.tex"

docker run --rm -v "${root}:/workspace" -w /workspace $Image sh -lc $containerCommand

if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

Write-Host "Generated ${Main}.pdf"
