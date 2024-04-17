#!/bin/sh

flutter pub run intl_utils:generate
dart format . --line-length=120