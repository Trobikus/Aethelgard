🏰 Project Aethelgard
Genre: Action‑MMORPG / Hack’n’Slash Hybrid
Plattformen: PC (Windows) – spätere Konsolenportierung möglich
Engine: Unreal Engine 5 (C++ / Blueprint)

📜 Vision
Project Aethelgard ist ein episches MMORPG, das die Loot‑getriebene Action von Hack’n’Slash‑Spielen mit der sozialen Tiefe einer persistenten Online‑Welt kombiniert.
Durch das dynamische Echo‑System wechseln Spieler fließend zwischen offener Welt und prozedural generierten Abenteuern – immer auf der Jagd nach Ausrüstung, Lore und Macht.

✨ Kernfeatures
- Dualer Fortschritt: Charakterlevel & Atlas der Echos
- Prozedurale Dungeons: Zufallsaffixe, Gegner und Loot
- Drei einzigartige Klassen: Warden, Mender, Reaper
- Koop‑Raids: Mehrstufige Bosskämpfe
- Saisonale Liga‑Struktur: Frische Mods & Herausforderungen

🗂 Repository‑Struktur
Project-Aethelgard/
├── docs/                # Design-Dokumente, Gantt-Pläne, Architektur-Skizzen
├── src/
│   ├── client/           # Spielclient (Assets, Scripts, UI)
│   ├── server/           # Serverlogik, API, Datenbank
│   └── shared/           # Gemeinsam genutzte Module
├── tools/                # Build-Skripte, Import-/Export-Tools
├── tests/                # Unit-, Integrations- & Lasttests
├── assets_raw/           # Original-Assets in hoher Qualität
├── .gitignore
├── README.md
├── LICENSE
└── CONTRIBUTING.md



🚀 Installation & Setup
1. Repository klonen
git clone https://github.com/<DeinAccount>/Project-Aethelgard.git
cd Project-Aethelgard


2. Abhängigkeiten installieren
- Unreal Engine 5 einrichten
- Falls nötig: Node.js / Python‑Tools für Build‑Skripte installieren
- Datenbank lokal konfigurieren (PostgreSQL empfohlen)
3. Environment‑Variablen setzen
Erstelle .env im Hauptverzeichnis mit:
DB_HOST=localhost
DB_USER=...
DB_PASS=...


4. Projekt starten
- Client: In Unreal Engine öffnen und starten
- Server: Startskript in src/server ausführen

🛠 Entwicklungs‑Workflow
- Branches:
- main – stabiler Produktionscode
- develop – aktueller Entwicklungszweig
- feature/<feature-name> – neue Features
- fix/<bug-name> – Bugfixes
- Pull Requests: PR‑Template ausfüllen, Code Reviews durchführen
- Code Style: Einheitliche Code- und Asset‑Namenskonventionen beachten (siehe CONTRIBUTING.md)
- Git LFS: Für große Dateien wie Texturen, Modelle und Sounds aktiviert

📅 Roadmap
- Detaillierte Zeitplanung: docs/Gantt-Plan.png
- Feature‑Beschreibung: docs/Living_Design_Document.md

🤝 Beitrag leisten
Siehe CONTRIBUTING.md für Richtlinien zu Branches, Commits und PRs.

📜 Lizenz
Dieses Projekt steht unter der MIT Lizenz.

📌 Kontakt
- Projektleitung: Max
- Discord: [Einladungslink einfügen]
- E‑Mail: [Adresse einfügen]
