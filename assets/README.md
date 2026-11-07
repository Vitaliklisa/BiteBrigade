# Assets

Table Talk's generated launcher icons, adaptive icon layers, web icons, and
splash images are created by `scripts/generate-flutter-icons.mjs`.

To regenerate the source images and apply them to the native projects:

```sh
node scripts/generate-flutter-icons.mjs
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

List any additional Flutter asset directories under `assets:` in
`pubspec.yaml`.
