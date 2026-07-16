# Sem4Tra 2026 Paper

**Title:** Building and Publishing a Railway Infrastructure Knowledge Graph:
Lessons Learned from SPARQL Anything, GeoSPARQL, SHACL and RINF Publication

For the *Seventh International Workshop on Semantics for Transport and Logistics*
(Sem4Tra 2026), co-located with the SEMANTiCS Conference 2026, Ghent, 15 September 2026.
Formatted in the CEUR-WS **CEURART** style for publication on
[CEUR-WS.org](https://ceur-ws.org/).

## Files

| File        | Purpose                                                        |
|-------------|---------------------------------------------------------------|
| `source/`   | LaTeX source files: `paper.tex`, `paper.bib`, `paper.xmpdata`. |
| `dependencies/` | External LaTeX dependencies such as `ceurart.cls`.       |
| `output/`   | Generated build artifacts, including `paper.pdf`.              |
| `README.md` | This file.                                                    |

## Building on Overleaf (recommended)

1. Open the CEUR-WS template:
   <https://www.overleaf.com/latex/templates/template-for-submissions-to-ceur-workshop-proceedings-ceur-ws-dot-org/wqyfdgftmcfw>
   (or the project shared with you). It already contains `ceurart.cls` and the
   Libertinus fonts required by CEUR.
2. Upload `paper.tex` and `paper.bib` into the project, replacing the sample
   `.tex`/`.bib`.
3. Set `paper.tex` as the main document and compile (pdfLaTeX). Overleaf runs the
   BibTeX pass automatically.

## Building locally

If you want to compile without Docker, you need a TeX distribution (TeX Live /
MiKTeX) **plus** `ceurart.cls`, which is stored in `dependencies/`. Point your
TeX search path at that folder before compiling:

```sh
set TEXINPUTS=../dependencies//;
cd source
pdflatex paper
bibtex   paper
pdflatex paper
pdflatex paper
```

## Building with Docker (recommended for local reproducibility)

Running only one `pdflatex` pass does not resolve bibliography references.
Use the provided script, which runs the full sequence from `source/` and writes
to `output/`:
`pdflatex -> bibtex -> pdflatex -> pdflatex`.

PowerShell:

```powershell
./build-pdf.ps1
```

Optional:

```powershell
# build a different main file (without .tex extension)
./build-pdf.ps1 -Main paper

# clean aux files before building
./build-pdf.ps1 -Clean
```

## Project layout

- `source/` contains the manuscript and bibliography sources.
- `dependencies/` contains the shared CEURART class file.
- `output/` contains all generated artifacts, so the repo root stays clean.

VS Code is configured with a default build task, so `Ctrl+Shift+B` runs the PDF
pipeline through `build-pdf.ps1`.

GitHub Actions runs the same pipeline on push and pull request events and
uploads `output/paper.pdf` as a workflow artifact.

## Sources

- Knowledge base: <https://github.com/Matdata-eu/Slides-W3C-Facade-X>
- Project portal: <https://dim.apps.banenor.no/>
- CEUR-WS instructions: <https://ceur-ws.org/HOWTOSUBMIT.html#CEURART>
