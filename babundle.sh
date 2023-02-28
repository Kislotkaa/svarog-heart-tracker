#!/bin/sh
flutter clean
flutter pub get
arch -x86_64 flutter build appbundle --release lib/main.dart