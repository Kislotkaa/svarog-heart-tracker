#!/bin/sh

fluttergen -c pubspec.yaml
dart format . --line-length=120