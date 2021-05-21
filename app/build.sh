#!/bin/sh

if [ -d "dist" ]; then
    rm -rf dist
fi

mkdir -p dist

go mod tidy

go build -ldflags="-s -w" -a -v -o servian_technical_challenge .

cp servian_technical_challenge dist/
cp -r assets dist/
cp conf.toml dist/

rm servian_technical_challenge
