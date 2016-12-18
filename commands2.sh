# splitte SVG
(mkdir splitted && cd splitted && csplit -n 3 ../*.svg '/^    </\?g/' '{*}')

# fuege SVG-Schnipsel zu validen svg-Dateien zusammen
(
    mkdir svg || exit
    cd splitted || exit
    last=$(ls -1 | tail -n 1)
    i=0
    while true; do
	f=$(printf "xx%03d" $((i+1)))
	test -f $f || break
	cat xx000 $f $last > ../svg/$f.svg
	i=$((i+2))
    done
)
ls -l svg

# finde Dateinamen, wo vorhanden:
for i in svg/xx*.svg; do
    declare -l t
    t=$(grep '^       inkscape:export-filename=' $i) \
      && echo mv -i $i $(dirname $i)/$(perl -pe 's,.*\\,,; s,.png.*,.svg,' <<< $t)
done

# verwende scour, um die Datei zu optimieren
mkdir stripped && for i in svg/*.svg; do scour -i $i -o stripped/$(basename $i) --enable-id-stripping --enable-comment-stripping --shorten-ids; done

# erzeuge Preview-PNGs
mkdir stripped-png && for i in stripped/*.svg; do f=$(basename $i); convert $i stripped-png/${f%.svg}.png; done

# Local Variables:
# mode: sh
# End:
