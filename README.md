# Meridian Advisory Group — Consulting Landing Page

A responsive one-page website for a strategy and management consulting firm,
built with Flutter Web.

**Live site:** https://alinchenescu.github.io/consulting-landing-page/

## Sections

| Menu       | Content                                                                 |
|------------|-------------------------------------------------------------------------|
| Home       | Hero with call-to-action buttons and an animated growth-dashboard illustration |
| About Us   | Mission, values cards (swiper on mobile) and animated key figures       |
| Services   | Four service cards with starting prices, deliverables and a "How we work" process |
| Contact    | Contact details, a validated consultation request form and an FAQ       |

All imagery is drawn in code (custom-painted parallax background, Material
icons and widget-based illustrations), so the project ships without image assets.
Section content is configured in `lib/src/home/pages/home_page.dart` and company
details in `lib/env/assets/constants.dart`.

## Run locally

Tested with Flutter 3.22.1.

```sh
flutter pub get
flutter run -d chrome
```

## Deploy to GitHub Pages

```sh
flutter build web --release --base-href /consulting-landing-page/
```

Then publish the contents of `build/web` to the `gh-pages` branch.

## Credits

Based on the MIT-licensed
[flutter_landing_page](https://github.com/Nialixus/flutter_landing_page)
template by Louis Wiwawan. See [LICENSE](LICENSE).
