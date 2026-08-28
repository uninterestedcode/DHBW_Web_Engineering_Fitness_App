# DHBW Sportler — Webanwendung

Projekt im Kurs Webprogrammierung, WWI25AMB, DHBW Mannheim, WS 2026/27.
Präsentation am 23.10.2026.

Eine Webanwendung, in die Studierende ihre Laufdaten aus bestehenden Apps
hochladen. Die Anwendung wertet die eigene Leistung aus und vergleicht sie mit
Kursen und Studiengängen der DHBW.

Sportart im aktuellen Umfang: Laufen. Krafttraining ist im fachlichen Modell
vorgesehen und in dieser Ausbaustufe nicht umgesetzt, siehe TE-09.

## Schnellstart

1. Git und VS Code installieren, Erweiterung **Live Server** hinzufügen.
2. Repository klonen, in VS Code öffnen.
3. `index.html` öffnen, unten rechts **Go Live** klicken.

Node.js und npm werden nicht benötigt. Ausführliche Anleitung:
[docs/06-entwicklungsumgebung.md](docs/06-entwicklungsumgebung.md).

Die Seite muss über `http://` geöffnet werden. Ein Doppelklick auf die Datei
verhindert das Laden der JavaScript-Module.

## Dokumentation

Die Dokumente sind Entwürfe. Verbindlich sind allein die als "entschieden"
gekennzeichneten Einträge in [Technische Entscheidungen](docs/07-technische-entscheidungen.md).

| Dokument | Inhalt |
|---|---|
| [Übersicht](docs/00-uebersicht.md) | Einstieg, Ablage der Dokumente |
| [Architektur](docs/01-architektur.md) | Aufbau, Datenfluss, Auslieferung |
| [Projektstruktur](docs/02-projektstruktur.md) | Ordner, Konventionen, Zuständigkeiten |
| [Datenkonzept](docs/03-datenkonzept.md) | Datenformat, Import, echte und simulierte Daten |
| [Seitenkonzept](docs/04-seitenkonzept.md) | Alle Seiten mit Zweck und Eigentümer |
| [Gestaltungskonzept](docs/05-gestaltungskonzept.md) | CSS-Aufbau, Tokens, Breakpoints |
| [Entwicklungsumgebung](docs/06-entwicklungsumgebung.md) | Einrichtung und Arbeitsablauf |
| [Technische Entscheidungen](docs/07-technische-entscheidungen.md) | Entscheidungen mit Begründung, offene Punkte |
| [Ausblick](docs/08-ausblick.md) | Umgesetzter Stand, mögliche Ausbaustufen |

## Technik

HTML, CSS und JavaScript mit ES-Modulen. Kein Framework, kein Build-Schritt.
Mehrere verlinkte HTML-Seiten, gemeinsames Layout über Custom Elements,
Datenhaltung in `localStorage`.

Die Anwendung soll ohne Server auskommen. Eigene Daten stammen aus dem CSV-Import,
alle übrigen Studierenden aus einem eingecheckten Simulationsdatensatz. Eine gemeinsame
Datenbank ist als Ausbaustufe beschrieben und nicht Teil des Zielumfangs, siehe
[Ausblick](docs/08-ausblick.md).

**Stand:** Dokumentation als Entwurf vorhanden, Quellcode noch nicht geschrieben.
Umsetzungsbeginn nach der HTML-Vorlesung am 04.09.2026.

## Fallstudie Systemanalyse

Umfeld, Projektauftrag, Use Cases, UML-Diagramme und das Glossar liegen in Notion
und Google Drive. Dieses Repository enthält die Webanwendung und ihre technische
Dokumentation.
