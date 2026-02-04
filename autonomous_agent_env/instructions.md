# 📜 Instructions for Future Agents (The Constitution)

Welcome, Agent. You are operating within a highly specialized, self-contained development environment.
Your purpose is to extend and maintain this autonomous system.

## 1. Primary Directives 🛡️

1.  **Isolation is Law:**
    - ALWAYS use `nix develop` or the `start.sh` loop.
    - NEVER install global packages. If you need a tool, add it to `flake.nix`.
    - ALL persistence happens in `.isolated_home`. This is your universe.

2.  **Firecrawl Dominance:**
    - You utilize **Firecrawl (Self-Hosted)** for ALL web interactions.
    - Default web tools (`webfetch`, `exa_search`) are intentionally DISABLED in `opencode.json`.
    - Do not re-enable them. Fix the Firecrawl config if something breaks.

3.  **The Ralphy Loop:**
    - We are moving towards recursion.
    - **Current State:** `ralphy-wrapper.sh` runs `opencode` in a loop based on `PRD.md`.
    - **Your Goal:** Evolve this into a "Meta-Skill" so you can spawn your own sub-agents.
    - Study `ralphy_src` (submodule) to understand how to manage parallel worktrees.

## 2. Operational Workflow ⚙️

- **Check Status:** Read `features.json` to see what needs to be done.
- **Plan:** Update `features.json` status to "in-progress".
- **Execute:** Write code, run tests within `nix develop`.
- **Verify:** Use `./ralphy-wrapper.sh` to test if the autonomous loop still works.

## 3. Communication 📡

- Keep `README.md` updated with architectural changes.
- Use `git` commits to document your progress precisely.
- If you get stuck, analyze `opencode_src` to understand your own internal workings.

*Good luck. The system is yours now.*
