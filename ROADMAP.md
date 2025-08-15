flowchart TD
    classDef done fill:#9be7a8,stroke:#2e7d32,color:#000
    classDef progress fill:#fff59d,stroke:#f9a825,color:#000
    classDef upcoming fill:#90caf9,stroke:#1565c0,color:#000

    A[Repo‑Feinschliff ✅]:::done --> B[Entwicklungs‑Setup ⚙️]:::progress
    B --> C[Projektinhalt 📂]:::upcoming
    C --> D[Frühe Entwicklungsphase 🚀]:::upcoming
    D --> E[Community & Sichtbarkeit 🌐]:::upcoming
    E --> F[Kontinuierliche Iteration 🔄]:::upcoming

    subgraph Phase 1: Repo‑Feinschliff
        A1[README mit Screenshots, Artworks, Teaser‑Video]:::done
        A2[Lizenz- & Kontaktinfos]:::done
        A3[CODE_OF_CONDUCT.md ergänzen]:::done
        A4[.gitignore & Git LFS prüfen]:::done
    end
    A --> A1 --> A2 --> A3 --> A4

    subgraph Phase 2: Entwicklungs‑Setup
        B1[Team einladen & Guidelines teilen]:::progress
        B2[Branch‑Workflow testen]:::progress
        B3[Build‑Pipeline einrichten]:::progress
    end
    B --> B1 --> B2 --> B3

    subgraph Phase 3: Projektinhalt
        C1[Verzeichnisstruktur anlegen]:::upcoming
        C2[Platzhalter‑Assets & Beispielcode]:::upcoming
        C3[Technische Doku starten]:::upcoming
    end
    C --> C1 --> C2 --> C3

    subgraph Phase 4: Frühe Entwicklungsphase
        D1[Core‑Mechaniken prototypen]:::upcoming
        D2[MVP definieren]:::upcoming
        D3[Interne Tests & Feedback]:::upcoming
    end
    D --> D1 --> D2 --> D3

    subgraph Phase 5: Community & Sichtbarkeit
        E1[Discussions/Discord aufsetzen]:::upcoming
        E2[Devlog‑Format bestimmen]:::upcoming
        E3[Externe Playtests]:::upcoming
    end
    E --> E1 --> E2 --> E3

    subgraph Phase 6: Kontinuierliche Iteration
        F1[Features in kurzen Zyklen]:::upcoming
        F2[PR‑Reviews & Tests]:::upcoming
        F3[Community‑Feedback integrieren]:::upcoming
    end
    F --> F1 --> F2 --> F3