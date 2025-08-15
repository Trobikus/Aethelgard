🤝 Contributing Guide – Project Aethelgard
Vielen Dank, dass du zu Project Aethelgard beitragen möchtest!
Dieses Dokument erklärt, wie wir zusammenarbeiten, um ein stabiles, skalierbares und spaßiges MMORPG zu bauen.
📋 Inhaltsverzeichnis
- Grundprinzipien
- Branch-Strategie
- Commit-Richtlinien
- Pull-Requests
- Code-Style & Assets
- Umgang mit Issues
- Tests & Builds
- Kommunikation

🛡 Grundprinzipien
- Schreibe sauberen, gut dokumentierten Code
- Jede Änderung wird getestet, bevor sie gemerged wird
- Assets und Code immer so ablegen, dass sie leicht auffindbar sind
- Achte auf Performance, Lesbarkeit und Wartbarkeit
- Respektvoller Umgang im Team ist oberstes Gebot

🌿 Branch-Strategie
- main – stabiler Produktionscode
- develop – aktueller Entwicklungszweig
- feature/<kurzer-name> – neue Features
- fix/<kurzer-name> – Bugfixes
- hotfix/<kurzer-name> – dringende Korrekturen im Produktionscode
Beispiele:
feature/combat-system
fix/echo-loot-bug
hotfix/server-crash-login

📝 Commit-Richtlinien
- Commit-Messages prägnant und auf Englisch
- Präsens verwenden („Add login screen“)
- Struktur:
<TYPE>: <Kurze Beschreibung>

<Optional: längere Erklärung>
- Types:
feat, fix, docs, style, refactor, test, chore

🔄 Pull-Requests
- PR aus feature/... oder fix/... gegen develop
- PR-Template ausfüllen
- Mindestens 1 Review eines Teammitglieds
- Konflikte vor dem Review selbst beheben
- Keine direkten Commits auf main

🎨 Code-Style & Assets
- Code: 4 Spaces, lower_snake_case für Skripte, klare Kommentare
- Assets:
- Texturen: tex_<beschreibung>.png
- Modelle: mdl_<beschreibung>.fbx
- Audio: sfx_<beschreibung>.wav oder mus_<beschreibung>.mp3
- Git LFS für große Dateien nutzen

🐞 Umgang mit Issues
- Issue-Templates für Bugs, Features, Tasks nutzen
- Problem, Kontext, erwartetes Ergebnis klar beschreiben
- Relevante Commits, Screenshots, Logs verlinken

🧪 Tests & Builds
- Unit Tests bei neuen Features
- Integrationstests für große Gameplay-Systeme
- Builds über GitHub Actions automatisiert
- Kein Merge, wenn Tests fehlschlagen

💬 Kommunikation
- Hauptkanal: Discord (Text & Voice)
- Kurze Absprachen → Discord
- Entscheidungen immer in docs/ dokumentieren
- Wichtige Ankündigungen im #dev-updates

🎯 Ziel
Sauber strukturierter Code, klare Prozesse und eine gesunde Teamkultur – so bringen wir Project Aethelgard von einer Vision in die Realität.
