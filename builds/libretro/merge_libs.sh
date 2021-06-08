#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "First arg must be path to the buildscripts lib folder"
    exit 1
fi

LIBPATH="$1/libpng.a"
if ! test -f "$LIBPATH"; then
  echo "libpng.a not found. First arg likely incorrect"
  exit 2
fi

if ! test -f "easyrpg_libretro.a"; then
  echo "easyrpg_libretro.a not found. Run script from repository root"
  exit 3
fi

OUTFILE=easyrpg.mri

set -e

echo "create easyrpg_libretro_merged.a" > $OUTFILE

echo "Adding liblcf"
echo "addlib lib/liblcf/liblcf.a" >> $OUTFILE

echo "Adding libretro_common"
echo "addlib builds/libretro/libretro_common.a" >> $OUTFILE

for lib in \
 expat \
 pixman-1 \
 png \
 z \
 icuuc \
 icui18n \
 icudata \
 freetype \
 harfbuzz \
 freetype \
 mpg123 \
 sndfile \
 vorbisidec \
 vorbisfile \
 vorbis \
 ogg \
 xmp-lite \
 WildMidi \
 speexdsp \
 samplerate \
 opusfile \
 opus;do

LIBPATH="$1/lib$lib.a"
 
if test -f "$LIBPATH"; then
  echo "Adding $lib"
  echo "addlib $LIBPATH" >> $OUTFILE
fi

done

echo "Adding easyrpg_libretro"
echo "addlib easyrpg_libretro.a" >> $OUTFILE

echo "save" >> $OUTFILE
echo "end" >> $OUTFILE

ar -M <easyrpg.mri

echo "Done. Created easyrpg_libretro_merged.a"
