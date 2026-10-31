# Tech Toolkit

A Flutter Android app that is a grid of small tech/finance tools. Today:

- **Stock Average** - enter an earlier purchase and a planned one, get total shares, total investment and the new average price.
- **Compound Interest** - principal, annual rate, duration in months, monthly or yearly compounding; shows total interest, final amount and a paginated period table.

## Adding a feature

1. Create `lib/features/<name>/` with a screen (use `FeatureScaffold`, `SectionCard`, `NumberField`, `HighlightTile` from `lib/widgets/common.dart`).
2. Add one `Feature(...)` entry to `lib/features/feature.dart`. It appears on the home grid.

## Ads and subscriptions

`lib/core/app_flags.dart` holds `adsEnabled` and `isPremium`. The banner (`lib/widgets/ad_banner.dart`) shows only when ads are on and the user is not premium. The tune icon on the home header flips both for testing. The banner is a placeholder; swap its body for an AdMob `BannerAd` when you have an AdMob account. When subscriptions ship, set `isPremium` from the purchase state.

## First-time setup

```bash
flutter create --platforms=android --org com.techtools --project-name tech_toolkit .
flutter pub get
flutter run
```

Commit the generated `android/` folder. Until then CI generates it on each build.

## Branches and releases

| Branch    | Purpose            | Build on push              |
|-----------|--------------------|----------------------------|
| `dev`     | day-to-day work    | debug APK                  |
| `staging` | pre-release testing| release APK                |
| `main`    | production         | release AAB + APK          |

Promotion is manual, from the GitHub Actions tab:

- **Promote dev to staging** merges `dev` into `staging`, then builds.
- **Promote staging to production** fast-forwards `main` to `staging`, then builds.

In GitHub, create environments `staging-approval` and `production-approval` (Settings > Environments) and add yourself as a required reviewer. Each promotion then needs a Run click and an approval click. If you protect `main` or `staging`, allow GitHub Actions to push to them.

Release builds are signed with the debug key until you add a Play upload keystore and `key.properties`.
