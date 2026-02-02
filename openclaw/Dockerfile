# Isolierte Benchmark-Umgebung für OpenClaw mit Sandboxing
# Nutzt Docker-in-Docker für OpenClaw's eingebautes Sandbox-Feature
FROM docker:24-dind

# Labels für eindeutige Identifikation
LABEL project="benchmark" \
      component="openclaw" \
      purpose="benchmark" \
      maintainer="coding_template"

# Node.js und Basis-Tools installieren
# make, g++, python3 sind nötig für node-llama-cpp Build
RUN apk add --no-cache \
    nodejs \
    npm \
    git \
    curl \
    jq \
    bash \
    make \
    g++ \
    cmake \
    python3 \
    linux-headers

# OpenClaw global installieren
RUN npm install -g openclaw@latest

# OpenClaw Sandbox-Konfiguration kopieren
# Aktiviert Docker-Sandboxing für alle Sessions
COPY openclaw.config.json /root/.openclaw/config.json

# Arbeitsverzeichnis erstellen
WORKDIR /workspace

# Standard-Benchmark PRD kopieren
COPY standard_tasks.md /workspace/PRD.md

# Start-Message
RUN echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"' >> /root/.bashrc && \
    echo 'echo "🦀 AGENT BENCHMARK: OpenClaw (Sandboxed)"' >> /root/.bashrc && \
    echo 'echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "🔒 SANDBOX: Alle Tool-Executions laufen in Docker-Containern"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "📋 SETUP:"' >> /root/.bashrc && \
    echo 'echo "   openclaw onboard    # Konfiguration starten"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "📋 TESTEN:"' >> /root/.bashrc && \
    echo 'echo "   openclaw \"Erstelle weather.js laut PRD.md\""' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc && \
    echo 'echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"' >> /root/.bashrc && \
    echo 'echo ""' >> /root/.bashrc

# Docker-Daemon + Bash starten
CMD ["sh", "-c", "dockerd-entrypoint.sh & sleep 2 && bash"]
