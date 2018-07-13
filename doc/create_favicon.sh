#!/bin/bash

INPUT="favicon.png"

convert -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 $INPUT output-16x16.ico
convert -resize x32 -gravity center -crop 32x32+0+0 -flatten -colors 256 $INPUT output-32x32.ico
convert output-16x16.ico output-32x32.ico favicon.ico
