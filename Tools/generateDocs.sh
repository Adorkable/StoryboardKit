#!/bin/sh

jazzy -o docs --swift-version 2.1
find ./docs/Classes/*.html | xargs grep 'Undocumented'
find ./docs/Classes/**/*.html  | xargs grep 'Undocumented'
find ./docs/Extensions/*.html  | xargs grep 'Undocumented'
