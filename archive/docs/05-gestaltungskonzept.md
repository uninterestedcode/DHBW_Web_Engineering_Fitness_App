# Gestaltungskonzept

> **Status: Vorschlag.** Dieses Dokument ist ein Entwurf. Es beschreibt einen möglichen Weg und wird verbindlich, sobald das Team ihn annimmt. Jede Angabe steht zur Diskussion. Beschlossene Punkte stehen in `07-technische-entscheidungen.md` mit dem Status entschieden.

## Ausgangspunkt schmaler Bildschirm

Die Gestaltung beginnt bei der Breite eines Telefons. Regeln für breitere Bildschirme werden über `min-width`-Abfragen ergänzt. Begründung: die Zielgruppe nutzt Trainings-Apps auf dem Telefon.

## Breakpoints

| Name | Ab Breite | Änderung |
|---|---|---|
| klein | 0 | eine Spalte, Menü eingeklappt |
| mittel | 48rem | zwei Spalten für Kacheln, Navigation ausgeklappt |
| gross | 72rem | drei Spalten, feste Maximalbreite des Inhalts |

## CSS-Dateien und Ladereihenfolge

1. `variables.css` — Custom Properties, keine Regeln
2. `base.css` — Reset, Typografie, Formularelemente
3. `layout.css` — Kopf, Navigation, Fuß, Raster, Kacheln
4. `seiten/<name>.css` — nur was ausschließlich diese Seite betrifft

Jede Seite lädt die ersten drei Dateien und höchstens eine eigene.

## Design-Tokens

Farben, Abstände und Schriftgrößen stehen ausschließlich in `variables.css` als Custom Properties. In den übrigen Dateien werden keine festen Werte geschrieben.

Vorgesehene Gruppen:

- Farben: Hintergrund, Fläche, Text, gedämpfter Text, Akzent, Erfolg, Warnung, Rahmen
- Abstände: eine Reihe aus sechs Stufen
- Schrift: Familie, vier Größen, zwei Gewichte
- Radien und Schatten: je zwei Stufen

Damit lassen sich Farbschema und Abstände an einer Stelle ändern.

## Dunkles Farbschema

Über `prefers-color-scheme` werden die Farbtokens neu gesetzt. Die übrigen Regeln bleiben unverändert. Der Aufwand beschränkt sich auf einen Block in `variables.css`.

## Komponenten

Wiederkehrende Komponenten, jeweils einmal in `layout.css` definiert:

Kopfleiste mit Navigation, Kachel für eine Kennzahl, Diagrammrahmen, Ranglisteneintrag, Trainingskarte, Hinweisfeld für leere Zustände, Schaltflächen in zwei Ausprägungen, Formularfeld mit Beschriftung und Fehlermeldung, Fußbereich.

## Klassennamen

Deutsche Begriffe, kleingeschrieben, Wörter mit Bindestrich getrennt. Der Name beschreibt die Komponente: `.kennzahl-kachel`, `.rangliste-eintrag`, `.rangliste-eintrag--eigen` für die hervorgehobene Zeile.

## Diagramme

Erste Wahl ist `canvas` mit einer Bibliothek, falls Bibliotheken zugelassen sind. Andernfalls werden die Diagramme als SVG im DOM erzeugt. Die Entscheidung hängt an der Rückfrage OP-01 in `07-technische-entscheidungen.md`.

Balken- und Liniendiagramme decken den Bedarf ab. Kreisdiagramme sind nicht vorgesehen, weil sich Anteile darin schlecht vergleichen lassen.

## Barrierefreiheit

- Kontrastverhältnis mindestens 4,5 zu 1 für Fließtext
- Sichtbare Fokusmarkierung auf allen bedienbaren Elementen
- Beschriftung für jedes Formularfeld über `<label for>`
- `aria-current="page"` für den aktiven Navigationspunkt
- Diagramme mit einer Textalternative oder einer Tabelle daneben
- Bedienung mit der Tastatur auf jeder Seite möglich

Diese Punkte sind im Vortrag am 23.10. erwähnenswert und mit geringem Aufwand umsetzbar.

## Schriften

Systemschriften über einen Schriftstapel. Damit entfällt ein externer Abruf, die Seite lädt schneller und es entsteht keine Übermittlung von IP-Adressen an Dritte. Der letzte Punkt passt zum Datenschutzkonzept.
