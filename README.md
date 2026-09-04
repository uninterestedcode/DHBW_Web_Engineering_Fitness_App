# DHBW Sportler — Webanwendung und Systemanalyse

Studienprojekt im 3. Semester, Studiengang Wirtschaftsinformatik, DHBW Mannheim, Kurs WWI25AMB, Wintersemester 2026/27.

Das Projekt bedient zwei Lehrveranstaltungen mit einem gemeinsamen Gegenstand. Die Fallstudie Systemanalyse liefert das Modell des Systems, die Webprogrammierung liefert die Oberfläche dazu. Auf Folie 26 der Fallstudie steht die Verbindung: "Programmiersprache kommt aus Webprojekt".

Der fachliche Gegenstand ist eine Webanwendung, in die Studierende ihre Laufdaten aus bestehenden Fitness-Apps hochladen. Die Anwendung wertet die eigene Leistung aus und vergleicht sie mit Kursen und Studiengängen der DHBW.

## Was in diesem Repository liegt

Das Repository hat zwei Arbeitsbereiche.

| Ort | Zweck | Werkzeug |
|---|---|---|
| Projektstamm | die Webanwendung selbst: HTML, CSS, JavaScript | Browser, VS Code, Live Server |
| [fallstudie_uml/](fallstudie_uml/) | die UML-Diagramme zur Anwendung | PlantUML |

Alles im Projektstamm gehört zur Webprogrammierung. Der Ordner `fallstudie_uml/` gehört zur Fallstudie Systemanalyse.

```
/
  index.html            Startseite und weitere Seiten der Anwendung
  css/  js/  daten/     Quellcode und Daten der Anwendung
  bilder/
  docs/                 technische Dokumentation der Anwendung
  fallstudie_uml/       UML-Diagramme
    *.puml              Quelltext eines Diagramms
    *.png  *.svg        daraus erzeugte Bilder
    render.sh           erzeugt alle Bilder neu
  PLANTUML.md           Einrichtung und Bedienung von PlantUML
  README.md             diese Datei
```

Der geplante Aufbau der Anwendung mit allen Seiten und Modulen steht in [docs/02-projektstruktur.md](docs/02-projektstruktur.md).

## Die zwei Lehrveranstaltungen

| | Webprogrammierung | Fallstudie Systemanalyse |
|---|---|---|
| Dozent | Dipl.-Ing. Dirk Henel | Prof. Dr. Frank Wolff |
| Ergebnis | Webauftritt aus verlinkten HTML-Seiten | UML-Modell, Präsentationen, Seminararbeit |
| Ablage im Repository | Projektstamm | `fallstudie_uml/` |
| Bewertung | Team-Note aus der Gruppenleistung | Präsentationen ab Use-Cases 25 %, Seminararbeit 75 % |
| Abschluss | Präsentation 23.10.2026, ca. 09:00 bis 16:00 | Abschlusspräsentation 23.10.2026, Abgabe 28.10.2026 in Moodle |

### Webprogrammierung

Sieben Vorlesungen mit je zwei Stunden Theorie und einer Stunde Praxis, jeweils 09:00 bis 12:15:

| Termin | Thema |
|---|---|
| 28.08.2026 | Einführung |
| 04.09.2026 | HTML |
| 11.09.2026 | HTML |
| 18.09.2026 | CSS |
| 25.09.2026 | CSS |
| 02.10.2026 | JavaScript |
| 09.10.2026 | PHP |
| 23.10.2026 | Präsentation der Web-Gruppen-Projekte |

Der Erwartungshorizont aus Folie 4 der ersten Vorlesung:

- Jedes Team bringt ein Startup-Thema auf eine Webseite.
- Der Kurs vermittelt HTML, CSS und JS für ein statisches Webseiten-Konstrukt.
- Am Ende steht ein Webauftritt aus verlinkten HTML-Seiten, der die Geschäftsidee abbildet.
- Jede Person im Team referiert. Die Note ist eine Team-Note.
- Jede Person wählt eine Unterseite und erklärt daran Begriffe aus dem Quellcode.

### Fallstudie Systemanalyse

| Termin | Ergebnis |
|---|---|
| 27.08.2026 | Festlegung Thema |
| 10.09.2026 | Umfeld und Use Cases (Klassenkandidaten) |
| 01.10.2026 | Fachliches Klassendiagramm mit Attributen und Relationen |
| 08.10.2026 | Aktivitätsdiagramm |
| 05.10.2026 | weitere UML-Diagramme, etwa Objekt-, Paket-, Sequenz-, Verteilungs- oder Zustandsdiagramm |
| 23.10.2026 | Abschlusspräsentation |
| 28.10.2026 | Abgabe der Seminararbeit in Moodle |

Die Reihenfolge der Termine 08.10. und 05.10. steht so auf Folie 30 der Fallstudie, Stand 26.08.2026. Die Folie trägt den Vermerk "ggf. anzupassen".

Die Seminararbeit umfasst 5 bis 8 Seiten Inhalt ohne Deckblatt und Anhang, im Format der OCG für die WI-Jahreskonferenz. Sie reflektiert die eigene Arbeit und verknüpft sie mit den Tätigkeiten davor und danach.

Folie 26 nennt UML als Standard für Klassen, Abläufe, Zustände und Use-Cases.

## Schnellstart Webanwendung

1. Git und VS Code installieren, Erweiterung **Live Server** hinzufügen.
2. Repository klonen, in VS Code öffnen.
3. `index.html` öffnen, unten rechts **Go Live** klicken.

Node.js und npm werden nicht gebraucht. Ausführliche Anleitung: [docs/06-entwicklungsumgebung.md](docs/06-entwicklungsumgebung.md).

Die Seite muss über `http://` geöffnet werden. Ein Doppelklick auf die Datei verhindert das Laden der JavaScript-Module.

## Schnellstart UML

1. Java 11 oder höher installieren.
2. VS-Code-Erweiterung installieren: `code --install-extension jebbs.plantuml`.
3. Eine `.puml`-Datei öffnen und `Alt+D` für die Vorschau drücken.

Alle Bilder auf einmal neu erzeugen:

```bash
cd fallstudie_uml
./render.sh
```

Einrichtung, Optionen, Notation und Fehlerbehandlung stehen in [PLANTUML.md](PLANTUML.md).

### Warum PlantUML

Folie 11 der Fallstudie nennt Bee-Up, Papyrus UML und Innovator von MID als Werkzeuge der Veranstaltung. PlantUML ist eine Abweichung davon. Der Grund: Ein Diagramm ist eine Textdatei, damit zeigt `git diff` jede geänderte Beziehung einzeln, und mehrere Personen können am selben Modell arbeiten.

Folie 27 verlangt, Werkzeuge zu begründen, wenn sie vom Standard abweichen. Diese Begründung gehört in die Kurzpräsentation und in [docs/07-technische-entscheidungen.md](docs/07-technische-entscheidungen.md).

## Technik der Anwendung

HTML, CSS und JavaScript mit ES-Modulen. Kein Framework, kein Build-Schritt. Mehrere verlinkte HTML-Seiten, gemeinsames Layout über Custom Elements, Datenhaltung in `localStorage`.

Die Anwendung kommt ohne Server aus. Eigene Daten stammen aus dem CSV-Import, alle übrigen Studierenden aus einem eingecheckten Simulationsdatensatz. Eine gemeinsame Datenbank ist als Ausbaustufe beschrieben und gehört nicht zum Zielumfang, siehe [docs/08-ausblick.md](docs/08-ausblick.md).

Sportart im aktuellen Umfang: Laufen. Krafttraining steht im fachlichen Modell und ist in dieser Ausbaustufe nicht umgesetzt, siehe TE-09.

## Dokumentation

Die Dokumente sind Entwürfe. Verbindlich sind allein die als "entschieden" gekennzeichneten Einträge in [Technische Entscheidungen](docs/07-technische-entscheidungen.md).

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
| [PlantUML](PLANTUML.md) | Werkzeug für die UML-Diagramme |

Umfeld, Projektauftrag, Glossar und die Präsentationen liegen in Notion und Google Drive. Fachliche Begriffe werden dort im Glossar festgelegt. Dieses Repository verwendet dieselben Begriffe und definiert sie kein zweites Mal.

## Arbeitsweise im Repository

Diese Regeln gelten für alle, die hier etwas ändern, auch für KI-Assistenten.

- **Zwei Bereiche trennen.** Änderungen an der Anwendung gehören in den Projektstamm, Änderungen am Modell in `fallstudie_uml/`.
- **Erzeugte Dateien.** `*.png` und `*.svg` in `fallstudie_uml/` werden aus der `.puml` erzeugt. Nach jeder Änderung an einer `.puml` läuft `./render.sh`, und die neuen Bilder werden mit committet. Die Bilder werden nie von Hand bearbeitet.
- **Sprache.** Dokumentation, Kommentare, CSS-Klassen und Bezeichner in JavaScript sind deutsch, damit sie zum Glossar passen. Dateinamen sind englisch und kleingeschrieben, ohne Umlaute, Wörter mit Bindestrich getrennt.
- **Status prüfen.** Vor einer Änderung an Architektur oder Datenformat gilt ein Blick in `docs/07-technische-entscheidungen.md`. Was dort als entschieden steht, gilt. Alles andere ist ein Entwurf.
- **Kein Build-Schritt.** Es gibt keine Paketverwaltung und keinen Bundler. Fremde Bibliotheken liegen als Datei unter `vendor/`, sofern das Team sie zulässt.
- **Zeitangaben.** Termine werden mit vollem Datum geschrieben, damit sie später eindeutig bleiben.

## Stand

Die Dokumentation liegt als Entwurf vor. Das Anwendungsfalldiagramm ist erstellt und liegt in `fallstudie_uml/`. Der Quellcode der Anwendung ist noch nicht geschrieben. Umsetzungsbeginn nach der HTML-Vorlesung am 04.09.2026.

## Offene Punkte

1. Der Name des Systems steht an zwei Stellen verschieden. Diese Datei und die Dokumente unter `docs/` sagen "DHBW Sportler", die Systemgrenze im Anwendungsfalldiagramm sagt "Hybrid Athletes". Das Team legt einen Namen fest und zieht ihn durch.
2. Die Anforderungen aus `impornatnt.md` sind noch nicht in das Seitenkonzept übernommen: Footer mit Datenschutz und Impressum, Kontaktseite, AGB, Widerrufsbelehrung als Schaltfläche, Profilseite ohne echte Funktion.
3. Die Wahl von PlantUML gegenüber den auf Folie 11 genannten Werkzeugen ist noch nicht in `docs/07-technische-entscheidungen.md` festgehalten.
