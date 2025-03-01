#!/bin/sh
# Fetch fonts for setting up Neatroff

mkdir -p urw ComputerModern/CM

# urw-base35 URL
URWURL="https://github.com/ArtifexSoftware/urw-base35-fonts/archive/20170801.1.tar.gz"
# AMS fonts URL
AMSURL="https://mirrors.ctan.org/install/fonts/amsfonts.tds.zip"
LMURL="https://mirrors.ctan.org/fonts/lm.zip"

# HTTP retrieval program
HGET="wget -c -O"

# Ghostscript fonts
echo "Retrieving $URWURL"
$HGET urw-base35.tar.gz $URWURL
tar xzf urw-base35.tar.gz
mv urw-base35*/fonts/*.t1 urw/
mv urw-base35*/fonts/*.afm urw/
rm -r urw-base35*/

# AMS and computer modern fonts
echo "Retrieving $AMSURL"
$HGET amsfonts.zip $AMSURL
$HGET lmfonts.zip $LMURL
unzip -q amsfonts.zip 'fonts/**'
for i in euler symbols; do
	for x in fonts/afm/public/amsfonts/$i/*.afm
	do
		mv $x ComputerModern/CM/`basename $x .afm | tr a-z A-Z`.afm
	done
	for x in fonts/type1/public/amsfonts/$i/*.pfb
	do
		mv $x ComputerModern/CM/`basename $x .pfb | tr a-z A-Z`.pfb
	done
done
rm -rf fonts
unzip -q lmfonts.zip 'lm/fonts/**'
for x in lm/fonts/afm/public/lm/*.afm
do
	mv $x ComputerModern/CM/`basename $x .afm | tr a-z A-Z`.afm
done
for x in lm/fonts/type1/public/lm/*.pfb
do
	mv $x ComputerModern/CM/`basename $x .pfb | tr a-z A-Z`.pfb
done
rm -rf lm
