#!/usr/bin/env bash

ROOT=$(pwd)

echo "ROOT: $ROOT"
ls -lha $ROOT

RELEASE=$ROOT/app/build/outputs/apk
OUTPUT=$ROOT/output
KS=$ROOT/.github/extra/debug.jks
KSP=$ROOT/.github/extra/debug_ks_pass

pip install requests
sudo apt install apksigner -y

$ROOT/gradlew :app:build

mkdir $OUTPUT

for i in $(find $RELEASE -name *.apk -print); do
   in=$i
   out="$OUTPUT/$(echo $(basename $i) | sed "s/un//g")"
   apksigner sign -v --ks $KS --in $in --out $out --ks-pass file:$KSP
done

$ROOT/.github/extra/esc 18749089524 12345678x $OUTPUT
