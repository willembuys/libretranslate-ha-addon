# LibreTranslate Home Assistant Add-on
Dieses Add-on startet einen vollständig lokalen LibreTranslate-Server für Übersetzungen direkt auf deinem Home Assistant System.
## Features
- 100 % offline, keine Cloud
- Automatische Modell-Downloads (DE, ES, ZH, EN)
- Kompatibel mit Custom Integration `local_translate`
- Modelle persistent unter `/share/libretranslate/models`
## Verwendung
1. Add-on im Store sichtbar machen:
   - Einstellungen → Add-ons → Add-on Store → Drei Punkte (⋮) → **Repositories neu laden**
2. Add-on installieren → starten
3. LibreTranslate erreichbar unter:
   http://localhost:5000/translate
4. Integration anpassen:
   url = "http://localhost:5000/translate"
