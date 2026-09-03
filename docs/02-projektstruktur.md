# Projektstruktur

> **Status: Vorschlag.** Dieses Dokument ist ein Entwurf. Es beschreibt einen möglichen
> Weg und wird verbindlich, sobald das Team ihn annimmt. Jede Angabe steht zur Diskussion.
> Beschlossene Punkte stehen in `07-technische-entscheidungen.md` mit dem Status
> entschieden.

## Ordner

```
/
  index.html              Startseite
  konzept.html            Idee, Problem, Nutzen
  laufen.html             Was die Anwendung aus Laufdaten berechnet
  dashboard.html          Anwendungsseite, eigene Auswertung
  rangliste.html          Anwendungsseite, Vergleich
  profil.html             Anwendungsseite, Kurszuordnung und Einstellungen
  team.html               Die vier Personen
  kontakt.html            Formular
  datenschutz.html        DSGVO-Hinweise
  impressum.html

  css/
    variables.css         Farben, Schriften, Abstände als Custom Properties
    base.css              Reset, Typografie, Grundelemente
    layout.css            Kopf, Navigation, Fuß, Raster
    seiten/               je Seite eine Datei, nur bei Bedarf

  js/
    layout.js             Custom Elements site-nav und site-footer
    model.js              internes Datenformat, Prüfung
    state.js              Zugriff auf localStorage
    cohort-source.js      einziger Zugriff auf die simulierte Kohorte
    import/
      strava.js           einziges Importmodul im aktuellen Umfang
    analysis/
      personal.js         Kennzahlen einer Person
      cohort.js           Vergleich, Rang, Perzentil
    views/                Renderfunktionen ohne eigene Datenhaltung
    pages/                ein Einstiegsmodul je Anwendungsseite

  daten/
    demo-data.json        simulierte Kohorte, einmal erzeugt und eingecheckt
    referenzwerte.json    veröffentlichte Normwerte mit Quellenangabe
    beispiel-csv/         echte Exporte des Teams als Testdaten

  vendor/                 fremde Bibliotheken als Datei, falls zugelassen
  bilder/
  docs/                   diese Dokumentation
  scripts/
    generate-demo-data.js einmal ausgeführt, Ergebnis wird eingecheckt
```

## Namenskonventionen

- Datei- und Ordnernamen: kleingeschrieben, ohne Umlaute, Wörter mit Bindestrich getrennt.
- CSS-Klassen: deutsch, kleingeschrieben, mit Bindestrich, zum Beispiel `.rangliste-eintrag`.
- JavaScript: Variablen und Funktionsnamen deutsch, damit sie zum Glossar passen.
  Ausnahme sind Schlüsselwörter und Namen aus der Browser-Schnittstelle.
- Dateinamen englisch, wie im Ordnerbaum oben. Die Regel zur deutschen Benennung gilt
  für Bezeichner im Code, nicht für Datei- und Ordnernamen.
- Kommentare und Commit-Nachrichten deutsch.

## Zuständigkeiten

Jede Seite hat genau eine verantwortliche Person. Wer eine Seite besitzt, bearbeitet
deren HTML-Datei und die zugehörige Datei unter `css/seiten/`. Damit entstehen bei der
gemeinsamen Arbeit kaum Konflikte.

Die Zuordnung steht in `04-seitenkonzept.md`.

Gemeinsame Dateien werden nur nach Absprache geändert: `variables.css`, `base.css`,
`layout.css` und `js/layout.js`. Eine Änderung dort wirkt auf jede Seite.

## Vorgabe aus dem Kurs

Folie 4 der Veranstaltungsunterlagen: jede Person wählt eine Unterseite und erklärt
Begriffe anhand des Quelltextes. Jede Person braucht deshalb mindestens eine Seite,
die sie selbst geschrieben hat.
