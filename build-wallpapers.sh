#!/bin/bash
# Builds the theme's wallpapers from the insignia in assets/ with ImageMagick
# and librsvg. Output lands in backgrounds/ at 3840x2160.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
mkdir -p backgrounds build

W=3840; H=2160
OLIVE_LIGHT="#3A452F"; OLIVE_DARK="#151A11"; GOLD="#C9A227"; CREAM="#EAE4D3"

# Ground: radial olive gradient with a light grain and a vignette.
magick -size ${W}x${H} radial-gradient:"$OLIVE_LIGHT"-"$OLIVE_DARK" \
  \( -size ${W}x${H} xc:gray50 -attenuate 0.35 +noise Gaussian -colorspace gray -blur 0x0.7 \) \
  -compose SoftLight -composite \
  \( -size ${W}x${H} radial-gradient:white-black -level 0%,140% \) \
  -compose Multiply -composite \
  build/ground.png

# Render each insignia crisp at its final height, with a soft drop shadow.
shadow() { # in out
  magick "$1" \( +clone -background black -shadow 55x28+0+18 \) +swap -background none -layers merge +repage "$2"
}
for k in 3id 2id 24id 1cav 35id; do
  rsvg-convert -h 560 -f png -o "build/$k.png" "assets/$k.svg"
  shadow "build/$k.png" "build/$k-s.png"
done
rsvg-convert -w 1040 -f png -o build/cib.png assets/cib.svg
shadow build/cib.png build/cib-s.png
magick assets/purpleheart.png -resize x640 build/ph.png
shadow build/ph.png build/ph-s.png

# Layout: caption, CIB, the five patches, the Purple Heart.
FONT="JetBrainsMono-NF-Bold"
[ "$(magick -list font | grep -c "Font: $FONT\$")" -gt 0 ] || FONT="DejaVu-Sans-Bold"

place() { # base overlay x y  (x/y = centre)
  local base=$1 ov=$2 cx=$3 cy=$4 w h
  w=$(magick identify -format "%w" "$ov"); h=$(magick identify -format "%h" "$ov")
  magick "$base" "$ov" -geometry +$((cx - w / 2))+$((cy - h / 2)) -composite "$base"
}

cp build/ground.png build/wall.png
magick build/wall.png -gravity North -font "$FONT" -pointsize 72 -kerning 30 -fill "$GOLD" \
  -annotate +0+250 "UNITED STATES ARMY" build/wall.png
place build/wall.png build/cib-s.png $((W / 2)) 560
row_y=1080; gap=140; pw=560
xs=( $((W / 2 - 2 * (pw + gap))) $((W / 2 - (pw + gap))) $((W / 2)) $((W / 2 + (pw + gap))) $((W / 2 + 2 * (pw + gap))) )
keys=(2id 3id 1cav 24id 35id)
for i in 0 1 2 3 4; do place build/wall.png "build/${keys[$i]}-s.png" "${xs[$i]}" $row_y; done
place build/wall.png build/ph-s.png $((W / 2)) 1760
magick build/wall.png -gravity South -font "$FONT" -pointsize 36 -kerning 14 -fill "$CREAM" -fill "#8A9478" \
  -annotate +0+60 "2ND ID  ·  3RD ID  ·  1ST CAV  ·  24TH ID  ·  35TH ID  ·  PURPLE HEART  ·  CIB" build/wall.png
magick build/wall.png -quality 95 backgrounds/divisions.png

# A quieter second wallpaper: just the CIB over the Purple Heart, off-centre.
cp build/ground.png build/wall2.png
place build/wall2.png build/cib-s.png $((W / 2)) $((H / 2 - 260))
place build/wall2.png build/ph-s.png $((W / 2)) $((H / 2 + 330))
magick build/wall2.png -quality 95 backgrounds/combat-infantryman.png

echo "built: $(ls backgrounds)"
