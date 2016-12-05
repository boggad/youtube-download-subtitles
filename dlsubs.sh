#!/usr/bin/env bash
LINKS_FILE=$1
while read -r link
do
	HTML="`wget -qO- $link`"
	SRV_LINK=$(echo "$HTML" | grep "TTS_URL" | python3 -c "import sys; import re; import urllib.parse; print(bytearray(urllib.parse.unquote(re.compile(r'.+\"(.+)\".+').match(sys.stdin.readline()).group(1)), 'utf-8').decode('unicode_escape').replace('\\\\','') + '&kind=asr&fmt=srv1&lang=en');")
	SRV_XML="`wget -qO- $SRV_LINK`"
	XML_FILENAME=$(echo "$link" | sed -r "s/.+v=(.+).+/\1/")
	echo "$SRV_XML" > $XML_FILENAME".xml"
	echo "Wrote xml to $XML_FILENAME.xml"
done < "$LINKS_FILE"

