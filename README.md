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
- Strava sync uses real OAuth via `https://pasue.com.ua/strava/callback` and the deep link `velpas://oauth/strava`.
- Server-side env vars are required: `STRAVA_CLIENT_ID`, `STRAVA_CLIENT_SECRET` (optional `STRAVA_DEEP_LINK`).
- Biometrics unlock uses `local_auth` and can be toggled in Settings.
- On macOS, secure storage falls back to the local DB if keychain entitlements are unavailable.
