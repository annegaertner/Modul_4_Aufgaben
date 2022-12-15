# Aufgabe_2_Shell
# skript: shell_befehle.sh
# Dieses Skript erstellt auf Basis einer unbereinigten Datei eine neue Datei, die nur die Spalten der ISSNs und Veröffentlichungsjahren enthält. 
# Autorin: Anne Gärtner

# directory wechseln
cd shell-lesson

# Überblick über Tabelle verschaffen
cat 2022-11-25-Article_list_dirty.tsv | head

# nummiert die Spalten und gibt strukturiert aus
head -n 1 2022-11-25-Article_list_dirty.tsv | tr "\t" "\n" | nl

# reduziert auf gewünschte Spalten (ISSN = Spalte 5, Date = Spalte 12)
cut -f 5,12 2022-11-25-Article_list_dirty.tsv

# Es zeigt sich, dass in den betreffenden Spalten nicht alle Zeilen besetzt sind bzw. z. T. unpassende Einträge stehen. Daher soll zunächst erreicht werden, dass ISSN und Date für jede Reihe auch in Spalte 5 bzw. 12 stehen.
# Es erfolgt eine genauere Betrachtung einzelner Spalten, um die Ungereimtheiten herauszufinden.

# Unpassende Einträge fixen, denn ein paar Reihen sind nach rechts verrutscht, weil in den ersten beiden Spalten dieser Reihen "IMPORTANT" steht
sed -r 's/IMPORTANT\t\t//' 2022-11-25-Article_list_dirty.tsv | cut -f 5,12

# zusätzlich: ISSN-Spalte bereinigen: "ISSN" (in allen Varianten) löschen (bzw. durch nichts ersetzen)
sed -r 's/IMPORTANT\t\t//' 2022-11-25-Article_list_dirty.tsv | sed -e 's/Issn://I' | sed -e 's/ISSN//I' | cut -f 5,12

# zusätzlich: überflüssige Leerzeichen in den Zellen bereinigen
sed -r 's/IMPORTANT\t\t//' 2022-11-25-Article_list_dirty.tsv | sed -e 's/Issn://I' | sed -e 's/ISSN//I' | sed -e 's/ //g' | cut -f 5,12

# zusätzlich: nur Zeilen auswählen, die besetzt sind, d. h. leere Zeilen werden nicht weiter berücksichtigt
sed -r 's/IMPORTANT\t\t//' 2022-11-25-cd sheArticle_list_dirty.tsv | sed -e 's/Issn://I' | sed -e 's/ISSN//I' | sed -e 's/ //g' | grep -P '\d{4}-\d{4}' | cut -f 5,12

# zusätzlich: Zeilen nach ISSN sortieren und redundante Zeilen nicht weiter berücksichtigen
sed -r 's/IMPORTANT\t\t//' 2022-11-25-Article_list_dirty.tsv | sed -e 's/Issn://I' | sed -e 's/ISSN//I' | sed -e 's/ //g' | grep -P '\d{4}-\d{4}' | cut -f 5,12 | sort | uniq

# Ergebnis in neuer Datei abspeichern
sed -r 's/IMPORTANT\t\t//' 2022-11-25-Article_list_dirty.tsv | sed -e 's/Issn://I' | sed -e 's/ISSN//I' | sed -e 's/ //g' | grep -P '\d{4}-\d{4}' | cut -f 5,12 | sort | uniq > 2022-11-25-Dates_and_ISSNs.tsv

# Der Abgleich zwischen der Musterlösung und meiner Lösung hat ergeben, dass ich eine Zeile weniger als Output bekomme. Bei mir fehlt die Zeile mit der ISSN 0003-813X. 
# Seltsamerweise befindet sie sich aber auch nicht in der Ausgangsliste, auf Basis derer wir die Aufgabe lösen sollten.
