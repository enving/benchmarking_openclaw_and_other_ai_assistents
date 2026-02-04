# 🤖 Autonomous OpenCode Agent (Nix-basiert)

Vollständig isolierte Entwicklungsumgebung für OpenCode + Firecrawl mit Antigravity-Authentifizierung.

## Voraussetzungen

- **Nix** mit Flakes aktiviert
  ```bash
  # Falls noch nicht installiert:
  sh <(curl -L https://nixos.org/nix/install) --daemon
  
  # Flakes aktivieren:
  mkdir -p ~/.config/nix
  echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
  ```

## Quick Start

```bash
# 1. Umgebung betreten
cd autonomous_agent_env
nix develop

# 2. Setup ausführen (nur beim ersten Mal)
./setup.sh

# 3. Authentifizieren
opencode auth login

# 4. Los geht's!
opencode
```

## Was ist isoliert?

ALLES. Diese Umgebung hat ein eigenes `$HOME`:

```
autonomous_agent_env/
└── .isolated_home/           ← Alles landet hier
    ├── .opencode/bin/opencode
    ├── .config/opencode/
    │   ├── opencode.json
    │   └── antigravity.json
    └── .npm-global/
        └── bin/firecrawl
```

Dein echtes `~/.config/opencode` bleibt unberührt.

## Befehle

| Befehl | Beschreibung |
|--------|--------------|
| `nix develop` | Umgebung betreten |
| `./setup.sh` | Installiert OpenCode + Firecrawl |
| `opencode auth login` | Authentifizierung |
| `opencode` | OpenCode starten |
| `firecrawl` | Firecrawl nutzen |
| `exit` | Umgebung verlassen |

## Aufräumen

```bash
# Alles löschen und neu anfangen:
rm -rf .isolated_home
```
