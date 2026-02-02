#!/bin/bash
# Startet die isolierte Benchmark-Umgebung für OpenClaw mit Sandboxing

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Eindeutige Naming-Convention für Benchmarks
IMAGE_NAME="benchmark/openclaw"
CONTAINER_NAME="benchmark--openclaw"

# Finde den richtigen User-Home (auch bei sudo)
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

echo "🔨 Building container..."
docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🦀 AGENT BENCHMARK: OpenClaw (Sandboxed)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "   Image:     $IMAGE_NAME"
echo "   Container: $CONTAINER_NAME"
echo ""
echo "🔒 SANDBOX-ARCHITEKTUR:"
echo "   └─ Äußerer Container (benchmark--openclaw)"
echo "      └─ OpenClaw Gateway"
echo "         └─ Sandbox-Container (Tool-Execution)"
echo ""
echo "📋 SETUP:"
echo "   openclaw onboard"
echo ""
echo "📋 TESTEN:"
echo "   openclaw \"Erstelle weather.js laut PRD.md\""
echo ""
echo "🌐 UI: http://localhost:31000"
echo ""
echo "🔍 Container-Filter: docker ps --filter 'label=project=benchmark'"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Lade globale .env aus benchmark/ (falls vorhanden)
BENCHMARK_DIR="$(dirname "$SCRIPT_DIR")/benchmark"
if [ -f "$BENCHMARK_DIR/.env" ]; then
    export $(grep -v '^#' "$BENCHMARK_DIR/.env" | xargs 2>/dev/null) || true
fi

# Lade lokale .env als Override (falls vorhanden)
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs 2>/dev/null) || true
fi

# --privileged ist nötig für Docker-in-Docker (OpenClaw Sandbox)
# Die eigentliche Isolation passiert durch OpenClaw's Sandbox-Feature
docker run -it --rm \
    --privileged \
    --name "$CONTAINER_NAME" \
    --label "project=benchmark" \
    --label "component=openclaw" \
    --label "purpose=benchmark" \
    -p 31000:3000 \
    "$IMAGE_NAME"

echo "✅ Container '$CONTAINER_NAME' beendet und gelöscht."
