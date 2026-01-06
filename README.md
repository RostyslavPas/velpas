# VelPas

Premium cycling community app for tracking bike component mileage, replacements, and wardrobe inventory.

## Run

```bash
flutter pub get
flutter gen-l10n
flutter run
```

If the platform folders (`android/`, `ios/`) are missing, run `flutter create .` once to generate them, then re-run the commands above.

## Notes

- First launch seeds a sample bike (Cervelo S5) with sample components.
- Pro is a mock flag stored in secure storage. The Paywall “Start Pro” and “Restore purchases” buttons simply enable Pro locally.
- Strava sync is a mock that generates 1–3 activities and updates bike mileage. No API keys are used.
- Biometrics unlock uses `local_auth` and can be toggled in Settings.
- On macOS, secure storage falls back to the local DB if keychain entitlements are unavailable.
