#!/usr/bin/env bash
#
# Erzeugt zu jeder .puml-Datei in diesem Ordner ein PNG und ein SVG.
#
# Aufruf (Git Bash, WSL, macOS, Linux):
#   ./render.sh              alle .puml in diesem Ordner
#   ./render.sh -r           zusaetzlich alle Unterordner
#   ./render.sh --png        nur PNG
#   ./render.sh datei.puml   nur diese Datei
#   ./render.sh -h           Hilfe
#
# Vor dem Rendern prueft das Skript jede Datei mit "plantuml -syntax".
# Bei einem Syntaxfehler nennt es Datei, Zeilennummer und Meldung und
# schreibt kein Bild. Der Exit-Code ist dann 1.
#
# Die Jar wird in dieser Reihenfolge gesucht:
#   1. Umgebungsvariable PLANTUML_JAR
#   2. plantuml.jar der VS-Code-Erweiterung jebbs.plantuml
#   3. Befehl "plantuml" im PATH

set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# ------------------------------------------------------------------
# Farben, abschaltbar ueber NO_COLOR oder wenn die Ausgabe kein Terminal ist
# ------------------------------------------------------------------
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  C_RED=$'\033[31m'; C_GREEN=$'\033[32m'; C_YELLOW=$'\033[33m'
  C_BOLD=$'\033[1m'; C_OFF=$'\033[0m'
else
  C_RED=''; C_GREEN=''; C_YELLOW=''; C_BOLD=''; C_OFF=''
fi

info()  { printf '%s\n' "$*"; }
ok()    { printf '%s\n' "${C_GREEN}$*${C_OFF}"; }
warn()  { printf '%s\n' "${C_YELLOW}$*${C_OFF}"; }
fail()  { printf '%s\n' "${C_RED}$*${C_OFF}"; }

usage() {
  cat <<'EOF'
render.sh - erzeugt PNG und SVG aus allen .puml-Dateien

  ./render.sh                alle .puml in diesem Ordner
  ./render.sh -r             zusaetzlich alle Unterordner
  ./render.sh --png          nur PNG erzeugen
  ./render.sh --svg          nur SVG erzeugen
  ./render.sh a.puml b.puml  nur die genannten Dateien
  ./render.sh -h             diese Hilfe

Umgebungsvariablen:
  PLANTUML_JAR   Pfad zu einer eigenen plantuml.jar
  NO_COLOR       schaltet die Farbausgabe ab
EOF
}

# ------------------------------------------------------------------
# Argumente
# ------------------------------------------------------------------
RECURSIVE=0
WANT_PNG=0
WANT_SVG=0
FILES=()

while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)      usage; exit 0 ;;
    -r|--recursive) RECURSIVE=1 ;;
    --png)          WANT_PNG=1 ;;
    --svg)          WANT_SVG=1 ;;
    -*)             fail "Unbekannte Option: $1"; usage; exit 2 ;;
    *)              FILES+=("$1") ;;
  esac
  shift
done

if [ "$WANT_PNG" -eq 0 ] && [ "$WANT_SVG" -eq 0 ]; then
  WANT_PNG=1
  WANT_SVG=1
fi

FORMATS=()
[ "$WANT_PNG" -eq 1 ] && FORMATS+=("png")
[ "$WANT_SVG" -eq 1 ] && FORMATS+=("svg")

# ------------------------------------------------------------------
# Java pruefen
# ------------------------------------------------------------------
if ! command -v java >/dev/null 2>&1; then
  fail "Java wurde nicht gefunden."
  info "  PlantUML braucht Java 11 oder hoeher."
  info "  Download: https://adoptium.net/"
  exit 3
fi

# ------------------------------------------------------------------
# plantuml.jar suchen
# ------------------------------------------------------------------
JAR=""
RUNNER=()

if [ -n "${PLANTUML_JAR:-}" ]; then
  if [ -f "$PLANTUML_JAR" ]; then
    JAR="$PLANTUML_JAR"
  else
    fail "PLANTUML_JAR zeigt auf eine Datei, die es nicht gibt:"
    info "  $PLANTUML_JAR"
    exit 3
  fi
fi

if [ -z "$JAR" ]; then
  # Windows-Benutzerordner, falls HOME davon abweicht (Git Bash)
  SEARCH_ROOTS=("$HOME")
  if [ -n "${USERPROFILE:-}" ]; then
    WIN_HOME="$(printf '%s' "$USERPROFILE" | sed 's|\\|/|g; s|^\([A-Za-z]\):|/\L\1|')"
    [ "$WIN_HOME" != "$HOME" ] && SEARCH_ROOTS+=("$WIN_HOME")
  fi

  for root in "${SEARCH_ROOTS[@]}"; do
    for ext_dir in "$root/.vscode/extensions" "$root/.vscode-insiders/extensions" "$root/.vscode-server/extensions"; do
      [ -d "$ext_dir" ] || continue
      candidate="$(ls -d "$ext_dir"/jebbs.plantuml-* 2>/dev/null | { sort -V 2>/dev/null || sort; } | tail -n 1)"
      if [ -n "$candidate" ] && [ -f "$candidate/plantuml.jar" ]; then
        JAR="$candidate/plantuml.jar"
        break 2
      fi
    done
  done
fi

if [ -n "$JAR" ]; then
  RUNNER=(java -jar "$JAR")
  SOURCE_NOTE="$JAR"
elif command -v plantuml >/dev/null 2>&1; then
  RUNNER=(plantuml)
  SOURCE_NOTE="$(command -v plantuml)"
else
  fail "plantuml.jar wurde nicht gefunden."
  info "  Erwartet wird die VS-Code-Erweiterung jebbs.plantuml, siehe PLANTUML.md."
  info "  Installation:  code --install-extension jebbs.plantuml"
  info "  Alternative:   PLANTUML_JAR=/pfad/zu/plantuml.jar ./render.sh"
  exit 3
fi

PU=("${RUNNER[@]}" -charset UTF-8)

# ------------------------------------------------------------------
# Graphviz pruefen
# ------------------------------------------------------------------
DOT_CHECK="$("${PU[@]}" -testdot 2>&1)"
if ! printf '%s' "$DOT_CHECK" | grep -q "Installation seems OK"; then
  fail "Graphviz-Pruefung fehlgeschlagen:"
  printf '%s\n' "$DOT_CHECK" | sed 's/^/  /'
  info "  Download: https://graphviz.org/download/"
  exit 3
fi

# ------------------------------------------------------------------
# Dateiliste aufbauen
# ------------------------------------------------------------------
if [ "${#FILES[@]}" -eq 0 ]; then
  if [ "$RECURSIVE" -eq 1 ]; then
    while IFS= read -r f; do FILES+=("$f"); done < <(find "$SCRIPT_DIR" -type f -name '*.puml' | sort)
  else
    while IFS= read -r f; do FILES+=("$f"); done < <(find "$SCRIPT_DIR" -maxdepth 1 -type f -name '*.puml' | sort)
  fi
fi

if [ "${#FILES[@]}" -eq 0 ]; then
  warn "Keine .puml-Datei gefunden in: $SCRIPT_DIR"
  [ "$RECURSIVE" -eq 0 ] && info "  Mit -r werden auch Unterordner durchsucht."
  exit 0
fi

info "${C_BOLD}PlantUML${C_OFF}   $SOURCE_NOTE"
info "${C_BOLD}Ordner${C_OFF}     $SCRIPT_DIR"
info "${C_BOLD}Formate${C_OFF}    ${FORMATS[*]}"
info "${C_BOLD}Dateien${C_OFF}    ${#FILES[@]}"
info ""

# ------------------------------------------------------------------
# Rendern
# ------------------------------------------------------------------
COUNT_OK=0
COUNT_FAILED=0
COUNT_WARN=0
FAILED_FILES=()

for src in "${FILES[@]}"; do
  if [ ! -f "$src" ]; then
    fail "FEHLER  $src"
    info "        Datei gibt es nicht."
    COUNT_FAILED=$((COUNT_FAILED + 1))
    FAILED_FILES+=("$src")
    continue
  fi

  rel="${src#"$SCRIPT_DIR"/}"
  base="$(basename "$src" .puml)"
  dir="$(dirname "$src")"

  # 1. Ohne @startuml gibt es nichts zu rendern.
  if ! grep -qE '^[[:space:]]*@startuml' "$src"; then
    fail "FEHLER  $rel"
    info "        Die Datei enthaelt kein @startuml."
    info "        Ein Diagramm beginnt mit @startuml und endet mit @enduml."
    info ""
    COUNT_FAILED=$((COUNT_FAILED + 1))
    FAILED_FILES+=("$rel")
    continue
  fi

  # 2. Syntaxpruefung. Schreibt keine Datei.
  #    Ausgabe bei Fehler:  ERROR / <Zeile, ab 0 gezaehlt> / <Meldung>
  syntax_out="$("${PU[@]}" -syntax < "$src" 2>&1)"
  if printf '%s' "$syntax_out" | head -n 1 | grep -q '^ERROR'; then
    line_no="$(printf '%s' "$syntax_out" | sed -n '2p')"
    message="$(printf '%s' "$syntax_out" | sed -n '3,$p')"
    if printf '%s' "$line_no" | grep -qE '^[0-9]+$'; then
      line_no=$((line_no + 1))
      source_line="$(sed -n "${line_no}p" "$src")"
    else
      line_no="?"
      source_line=""
    fi

    fail "FEHLER  $rel"
    info "        Zeile $line_no"
    printf '%s\n' "$message" | sed 's/^/        /'
    [ -n "$source_line" ] && info "        > $source_line"
    info "        Kein Bild geschrieben."
    info ""
    COUNT_FAILED=$((COUNT_FAILED + 1))
    FAILED_FILES+=("$rel")
    continue
  fi

  # 3. Name hinter @startuml bestimmt den Namen der Bilddatei.
  uml_name="$(grep -m 1 -oE '^[[:space:]]*@startuml[[:space:]]+[^[:space:]]+' "$src" | awk '{print $2}')"
  out_base="${uml_name:-$base}"
  if [ -n "$uml_name" ] && [ "$uml_name" != "$base" ]; then
    warn "HINWEIS $rel"
    info "        @startuml heisst \"$uml_name\", die Datei heisst \"$base\"."
    info "        Die Bilder heissen deshalb $uml_name.png und $uml_name.svg."
    COUNT_WARN=$((COUNT_WARN + 1))
  fi

  # 4. Rendern
  file_ok=1
  written=()
  for fmt in "${FORMATS[@]}"; do
    render_out="$("${PU[@]}" "-t$fmt" "$src" 2>&1)"
    render_rc=$?
    target="$dir/$out_base.$fmt"
    if [ "$render_rc" -ne 0 ]; then
      fail "FEHLER  $rel  ($fmt)"
      [ -n "$render_out" ] && printf '%s\n' "$render_out" | sed 's/^/        /'
      file_ok=0
    elif [ ! -f "$target" ]; then
      fail "FEHLER  $rel  ($fmt)"
      [ -n "$render_out" ] && printf '%s\n' "$render_out" | sed 's/^/        /'
      info "        Erwartete Ausgabe fehlt: $target"
      info "        Enthaelt die Datei mehrere @startuml-Bloecke?"
      file_ok=0
    else
      # PlantUML kann bei Erfolg Hinweise ausgeben, etwa zu Schriftarten.
      [ -n "$render_out" ] && printf '%s\n' "${C_YELLOW}$render_out${C_OFF}" | sed 's/^/        /'
      written+=("$out_base.$fmt")
    fi
  done

  if [ "$file_ok" -eq 1 ]; then
    ok "OK      $rel  ->  ${written[*]:-}"
    COUNT_OK=$((COUNT_OK + 1))
  else
    info ""
    COUNT_FAILED=$((COUNT_FAILED + 1))
    FAILED_FILES+=("$rel")
  fi
done

# ------------------------------------------------------------------
# Zusammenfassung
# ------------------------------------------------------------------
info ""
info "${C_BOLD}Zusammenfassung${C_OFF}"
ok   "  erzeugt:  $COUNT_OK"
[ "$COUNT_WARN" -gt 0 ]   && warn "  Hinweise: $COUNT_WARN"
[ "$COUNT_FAILED" -gt 0 ] && fail "  Fehler:   $COUNT_FAILED"

if [ "$COUNT_FAILED" -gt 0 ]; then
  info ""
  fail "Fehlgeschlagen:"
  for f in "${FAILED_FILES[@]}"; do
    info "  $f"
  done
  exit 1
fi

exit 0
