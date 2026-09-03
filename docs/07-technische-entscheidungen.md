# Technische Entscheidungen

Eine Zeile je Entscheidung. Fachliche Entscheidungen zur Fallstudie stehen in Notion.
Dieses Dokument behandelt die Umsetzung der Webanwendung.

Jeder Eintrag trägt einen Status:

- **entschieden** — im Team besprochen und angenommen. Eine Änderung braucht eine
  neue Absprache.
- **Vorschlag** — von einer Person eingebracht, noch nicht im Team bestätigt.

Die übrigen Dokumente in `docs/` sind durchgehend Vorschläge. Verbindlich ist
ausschließlich, was hier als entschieden steht.

## TE-01 HTML, CSS und JavaScript ohne Framework

Status: **entschieden**
Kontext: React stand zur Wahl, eine Person im Team hat Erfahrung darin.
Entscheidung: HTML, CSS und JavaScript ohne Framework.
Begründung: Drei von vier Personen lernen diese Techniken im selben Zeitraum. Der Kurs
prüft sie. Folie 4 verlangt, dass jede Person Begriffe anhand des Quelltextes einer
Unterseite erklären kann.
Verworfen: React, weil damit nur eine Person Fehler beheben könnte und die geprüften
Techniken verdeckt würden.

## TE-02 Mehrere eigenständige HTML-Seiten

Status: **entschieden**
Kontext: Eine einseitige Anwendung mit Router war im Gespräch.
Entscheidung: Eigenständige HTML-Dateien, Navigation über Verweise.
Begründung: Jede Person besitzt eigene Dateien und kann ab der zweiten HTML-Vorlesung
arbeiten. Der Quelltext einer Seite enthält deren Inhalt.
Verworfen: Einseitige Anwendung, weil der Quelltext dann aus einem leeren Container
besteht und die drei Anfängerinnen und Anfänger bis Oktober nicht mitarbeiten könnten.

## TE-03 Kein Build-Schritt

Status: **entschieden**
Kontext: Vite mit npm gegenüber einfachen Dateien mit Live Server.
Entscheidung: Keine Build-Werkzeuge. Live Server für die Entwicklung. Bibliotheken
werden als Datei unter `vendor/` abgelegt.
Begründung: Der Kurs arbeitet mit Editor, lokalem Server und FTP. Ohne Build-Schritt
entfällt eine Fehlerquelle vor der Präsentation und npm muss niemand lernen.

## TE-04 Gemeinsames Layout über Custom Elements

Status: **entschieden**
Kontext: Kopf und Fuß auf zehn Seiten identisch halten.
Entscheidung: `<site-nav>` und `<site-footer>` als Custom Elements in `js/layout.js`.
Der aktive Punkt wird über `location.pathname` bestimmt und mit `aria-current="page"`
markiert.
Begründung: Eine Definition gilt für alle Seiten. Für die Seitenbesitzer genügt ein
einzelnes Tag in der eigenen Datei.
Verworfen: Kopieren in jede Datei, weil jede Änderung zehn Dateien betrifft.
Zurückgestellt: PHP-Include. Das setzt einen Webspace mit PHP voraus, siehe OP-03.
Grenze: Der Umfang bleibt auf Kopf und Fuß beschränkt.

## TE-05 Simulierte Kohorte

Status: **entschieden**
Kontext: Ranglisten benötigen Daten mehrerer Personen. Der Browser hat keinen Zugriff
auf die Daten anderer Browser.
Entscheidung: Eigene Daten echt aus dem CSV-Import. Alle anderen Personen aus
`daten/demo-data.json`. Die Rangliste rechnet über beide Bestände.
Begründung: Der Kurs vermittelt keine serverseitige Entwicklung vor dem 09.10.
Gesundheitsdaten unterliegen Art. 9 DSGVO, weshalb keine echten Trainingsdaten von
Mitstudierenden erhoben werden.
Folge: `cohort-source.js` ist die einzige Stelle, die die Datei liest, und damit der
Punkt für einen späteren Austausch.

## TE-06 Motivationstexte vorab erzeugt

Status: **Vorschlag**
Kontext: Ein Aufruf einer KI-Schnittstelle aus dem Browser legt den Schlüssel offen.
Entscheidung: Texte während der Entwicklung erzeugen und als Datei ausliefern. Zur
Laufzeit wird anhand der erkannten Situation ausgewählt.
Begründung: Kein Schlüssel im Quelltext, keine Abhängigkeit vom Netz im
Präsentationsraum, gleichbleibende Textqualität. Das Vorgehen ist in der Seminararbeit
darstellbar.

## TE-07 Gestaltung ab schmalem Bildschirm

Status: **entschieden**
Kontext: Die Zielgruppe nutzt Trainings-Apps auf dem Telefon.
Entscheidung: Grundgestaltung für schmale Bildschirme, Erweiterung über
`min-width`-Abfragen.

## TE-08 Hash-Router nur im Dashboard

Status: **Vorschlag**
Kontext: Der Wechsel zwischen den Ansichten soll ohne Seitenwechsel erfolgen.
Entscheidung: `location.hash` und das Ereignis `hashchange`, begrenzt auf
`dashboard.html`.
Begründung: Zurück-Taste und direkte Verweise funktionieren, ohne dass die gesamte
Website zu einer einzelnen Seite wird. Keine Serverkonfiguration nötig.
Verworfen: History-API für die gesamte Seite, weil dafür jede Adresse serverseitig auf
`index.html` umgeschrieben werden müsste.

## TE-09 Umfang auf Laufen begrenzt

Status: **entschieden**
Kontext: Die Fallstudie nannte zunächst Gym und Laufen. In Notion steht dazu E-01.
Entscheidung: Die Webanwendung setzt in dieser Ausbaustufe ausschließlich Laufen um.
Begründung: Der Umfang halbiert sich. Es bleibt ein Importmodul und ein Datentyp;
mit Gym waren es drei Importmodule und vier Datentypen. Die Referenzwerte für Laufen
sind veröffentlicht und belegbar. Drei Personen im Team lernen HTML, CSS und JavaScript parallel zur Umsetzung.
Folge für die Systemanalyse: Das fachliche Klassendiagramm behält die abstrakte
Trainingseinheit mit Laufeinheit als einziger gebauter Ausprägung. Krafteinheit,
Übung und Satz bleiben als geplante Erweiterung im Modell. Die Vererbungsbeziehung
bleibt damit im UML-Modell erhalten.
Folge für das Datenformat: Das Feld Art bleibt bestehen und trägt aktuell nur den
Wert `laufen`.

## TE-10 Eigene Daten in localStorage

Status: **Vorschlag**
Kontext: Die hochgeladenen Trainingsdaten könnten im Arbeitsspeicher, in
`sessionStorage` oder in `localStorage` liegen.
Entscheidung: `localStorage`, gekapselt in `state.js`.
Begründung: Die Anwendung ist mehrseitig, siehe TE-02. Ein Wechsel von `dashboard.html`
zu `rangliste.html` lädt die Seite neu. Daten im Arbeitsspeicher wären dabei verloren
und müssten bei jedem Seitenwechsel erneut hochgeladen werden. `localStorage` überdauert
zusätzlich das Schließen des Browsers, wodurch für die Präsentation am Vorabend
vorbereitet werden kann.
Verworfen: Arbeitsspeicher, weil bei einer mehrseitigen Anwendung unbrauchbar.
Zurückgestellt: `sessionStorage`. Gleiche Schnittstelle, ein Wort in `state.js`.
Grenze: Die Daten hängen an einem Browser auf einem Gerät. `profil.html` bietet das
Löschen an.

## Offene Punkte

| Nr. | Frage | Wer klärt | Bis |
|---|---|---|---|
| OP-01 | Sind Bibliotheken wie Chart.js und PapaParse zugelassen? | Rückfrage an Henel | 04.09.2026 |
| OP-02 | Gemeinsame Datenbasis: simulierte Kohorte behalten, Supabase oder PHP mit MySQL | Team | 09.10.2026 |
| OP-03 | Veröffentlichung über GitHub Pages, FTP-Webspace oder beides | Team | 25.09.2026 |
| OP-05 | Repository öffentlich schalten. GitHub Pages verlangt das im kostenlosen Tarif | T1 | 25.09.2026 |
| OP-04 | Vergabe der Seiteneigentümerschaft, siehe `04-seitenkonzept.md` | Team | 04.09.2026 |

OP-01 bestimmt, ob Diagramme mit einer Bibliothek oder als eigenes SVG entstehen.

OP-02 kennt drei Antworten. Vergleich, Aufwand und Kosten stehen in `08-ausblick.md`.

1. Bei der simulierten Kohorte bleiben. Kein Aufwand, kein Risiko, präsentationsfähig.
2. Supabase ergänzen, Zuordnung über die Matrikelnummer ohne Passwort. Etwa ein halber
   Tag. Ergibt echte Ranglisten über mehrere Personen.
3. PHP und MySQL auf einem Webspace. Etwa ein Tag, entspricht dem Kursstoff aus
   Vorlesung 7 und Folie 13.

Die Antwort berührt `cohort-source.js` und den Schreibweg des Uploads. Alles Übrige
bleibt unberührt. Ein Betrieb auf einem eigenen Rechner ist geprüft und verworfen.
