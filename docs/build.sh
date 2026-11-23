#!/usr/bin/env bash
#
# Builds the monitor stand build guide.
#   ./docs/build.sh        -> dist/monitor-stand-build-guide.pdf
# Needs XeLaTeX + latexmk (MacTeX / TeX Live). Fonts live in docs/latex/fonts/.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}/docs/latex"
latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error main.tex >/dev/null || {
  echo "LaTeX error. Last lines of the log:" >&2
  grep -n -A3 -E '^\./.*:[0-9]+:|^! ' main.log | head -40 >&2
  exit 1
}
mkdir -p "${ROOT}/dist"
cp main.pdf "${ROOT}/dist/monitor-stand-build-guide.pdf"
echo ">> PDF: dist/monitor-stand-build-guide.pdf"
