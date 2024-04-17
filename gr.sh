#!/bin/sh

flutter packages pub run build_runner build
dart format . --line-length=120