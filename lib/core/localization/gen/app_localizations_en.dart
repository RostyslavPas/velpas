// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => 'Bike components & gear tracker';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => 'Track your bike. Know your gear.';

  @override
  String get aboutDescription =>
      'PROS.TO is a premium cycling app built for riders who care about their equipment.\nTrack mileage and wear for every bike component, keep replacement history, and understand the true cost of your setup.\nDesigned with a dark, minimal interface and warm metallic accents for clarity and focus.\n\nKey features:\n• Bike garage with photos and value\n• Component mileage & wear tracking\n• Replacement history and cost insights\n• Cycling gear wardrobe (helmets, shoes, kits and more)\n• Offline-first performance\n• Face ID / Touch ID app lock\n• English & Ukrainian language support\n\nPROS.TO Pro:\n• Strava sync (automatic mileage updates)\n• Unlimited bikes and components';

  @override
  String get homeTitle => 'Home';

  @override
  String get garageTitle => 'Garage';

  @override
  String get wardrobeTitle => 'Wardrobe';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTab => 'Settings';

  @override
  String get lastSyncTitle => 'Last sync';

  @override
  String get lastSyncNever => 'Never synced';

  @override
  String get addReplacement => 'Add replacement';

  @override
  String get syncStrava => 'Sync Strava';

  @override
  String get yourBikes => 'Your bikes';

  @override
  String get emptyGarageTitle => 'No bikes yet';

  @override
  String get emptyGarageSubtitle =>
      'Add your first bike to start tracking components.';

  @override
  String get addBike => 'Add bike';

  @override
  String totalKmLabel(Object km) {
    return '$km km total';
  }

  @override
  String get noComponentsYet => 'No components yet';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return 'Top alert: $brand $model • $wearPercent%';
  }

  @override
  String get statusOk => 'OK';

  @override
  String get statusWatch => 'Watch';

  @override
  String get statusReplace => 'Replace soon';

  @override
  String get statusReplaceNow => 'Replace now';

  @override
  String get selectBike => 'Select bike';

  @override
  String get selectComponent => 'Select component';

  @override
  String syncSuccess(Object added, Object summary) {
    return 'Imported $added rides • $summary';
  }

  @override
  String get bikeDetailTitle => 'Bike detail';

  @override
  String get bikeNotFound => 'Bike not found';

  @override
  String get componentsTitle => 'Components';

  @override
  String get addComponent => 'Add component';

  @override
  String get categoryDrivetrain => 'Drivetrain';

  @override
  String get categoryWheelsTires => 'Wheels & Tires';

  @override
  String get categoryBrakes => 'Brakes';

  @override
  String get categoryCockpit => 'Cockpit';

  @override
  String get categoryOther => 'Other';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '$km km since install • $expected km life';
  }

  @override
  String purchasePriceLabel(Object price) {
    return 'Purchase price: $price';
  }

  @override
  String get componentType => 'Component type';

  @override
  String get componentTypeChain => 'Chain';

  @override
  String get componentTypeCassette => 'Cassette';

  @override
  String get componentTypeChainring => 'Chainring';

  @override
  String get componentTypePowerMeter => 'Power meter';

  @override
  String get componentTypeShifters => 'Shifters';

  @override
  String get componentTypeRearDerailleur => 'Rear derailleur';

  @override
  String get componentTypeFrontDerailleur => 'Front derailleur';

  @override
  String get componentTypeWheels => 'Wheels';

  @override
  String get componentTypeTires => 'Tires';

  @override
  String get componentTypeBrakes => 'Brakes';

  @override
  String get componentTypeCockpit => 'Cockpit';

  @override
  String get componentTypeOther => 'Other';

  @override
  String get brandLabel => 'Brand';

  @override
  String get modelLabel => 'Model';

  @override
  String get expectedLifeLabel => 'Expected life (km)';

  @override
  String get priceOptionalLabel => 'Price (optional)';

  @override
  String get saveLabel => 'Save';

  @override
  String installedAtKm(Object km) {
    return 'Installed at $km km';
  }

  @override
  String get editBike => 'Edit bike';

  @override
  String get bikeNameLabel => 'Bike name';

  @override
  String get requiredField => 'Required';

  @override
  String get purchasePriceOptional => 'Purchase price (optional)';

  @override
  String get deleteBike => 'Delete bike';

  @override
  String get bikePhotoLabel => 'Bike photo';

  @override
  String get pickPhoto => 'Tap to pick a photo';

  @override
  String get photoPickerUnavailable =>
      'Photo picker is not available on this platform.';

  @override
  String get componentDetailTitle => 'Component detail';

  @override
  String get componentNotFound => 'Component not found';

  @override
  String get replaceComponent => 'Replace component';

  @override
  String get replacementHistory => 'Replacement history';

  @override
  String get noHistory => 'No replacement history yet';

  @override
  String removedAtKm(Object km) {
    return 'Removed at $km km';
  }

  @override
  String get removalKmLabel => 'Removal odometer';

  @override
  String currentBikeKmLabel(Object km) {
    return 'Current bike km: $km';
  }

  @override
  String get newComponentTitle => 'New component';

  @override
  String get totalGearValue => 'Total gear value';

  @override
  String itemsCount(Object count) {
    return '$count items';
  }

  @override
  String get categoryHelmets => 'Helmets';

  @override
  String get categoryGlasses => 'Glasses';

  @override
  String get categoryJerseys => 'Jerseys';

  @override
  String get categoryBibs => 'Bibs';

  @override
  String get categoryShoes => 'Shoes';

  @override
  String get categoryGloves => 'Gloves';

  @override
  String get categoryJackets => 'Jackets';

  @override
  String get categoryAccessories => 'Accessories';

  @override
  String get emptyWardrobeCategory => 'No items yet';

  @override
  String itemQuantity(Object quantity) {
    return 'Qty $quantity';
  }

  @override
  String get addItem => 'Add item';

  @override
  String get editItem => 'Edit item';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get notesLabel => 'Notes';

  @override
  String get deleteItem => 'Delete item';

  @override
  String get totalBikeValue => 'Total bike value';

  @override
  String totalKmAllBikes(Object km) {
    return 'Total distance: $km km';
  }

  @override
  String totalGearValueLabel(Object value) {
    return 'Total gear value: $value';
  }

  @override
  String get perBikeBreakdown => 'Per-bike breakdown';

  @override
  String bikeValueLabel(Object value) {
    return 'Bike value: $value';
  }

  @override
  String get languageTitle => 'Language';

  @override
  String get currencyTitle => 'Currency';

  @override
  String get currencyUsd => 'US Dollar (\$)';

  @override
  String get currencyEur => 'Euro (€)';

  @override
  String get currencyUah => 'Ukrainian Hryvnia (₴)';

  @override
  String get primaryBikeTitle => 'Primary bike';

  @override
  String get primaryBikeLabel => 'Select primary bike';

  @override
  String get primaryBikeNone => 'No primary bike';

  @override
  String get primaryBikeEmpty => 'Add a bike to choose a primary one.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Ukrainian';

  @override
  String get biometricToggleTitle => 'FaceID/TouchID unlock';

  @override
  String get biometricToggleSubtitle => 'Require biometrics on launch';

  @override
  String get subscriptionTitle => 'Subscription';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => 'Free';

  @override
  String get upgradeToPro => 'Upgrade to Pro';

  @override
  String get cancelPro => 'Cancel Pro';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava connected';

  @override
  String get stravaDisconnected => 'Strava not connected';

  @override
  String get stravaLocked => 'Strava sync is Pro-only';

  @override
  String get stravaConnectRequired => 'Connect Strava to sync.';

  @override
  String get stravaSessionExpired =>
      'Strava session expired. Please reconnect.';

  @override
  String get stravaSyncFailed => 'Strava sync failed. Try again.';

  @override
  String get stravaAuthFailed => 'Unable to open Strava. Try again.';

  @override
  String get stravaImporting => 'Importing Strava bikes...';

  @override
  String get stravaImportBikes => 'Import bikes from Strava';

  @override
  String get stravaImportFailed => 'Strava import failed. Try again.';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return 'Imported $added, linked $linked, skipped $skipped.';
  }

  @override
  String get connectStrava => 'Connect Strava';

  @override
  String get disconnectStrava => 'Disconnect Strava';

  @override
  String get accountTitle => 'Account';

  @override
  String get phoneAuthStub => 'Phone login is coming soon.';

  @override
  String get openAuth => 'Open login';

  @override
  String get aboutTitle => 'About';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle => 'Unlock premium maintenance and sync features.';

  @override
  String get proBenefitStrava => 'Strava sync';

  @override
  String get proBenefitUnlimited => 'Unlimited bikes & components';

  @override
  String get proBenefitAlerts => 'Smart alerts (coming soon)';

  @override
  String get proPrice => '\$5 / month';

  @override
  String get proPriceNote => 'Cancel anytime';

  @override
  String get startPro => 'Start Pro';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get phoneAuthTitle => 'Phone registration';

  @override
  String get phoneAuthSubtitle => 'Sign in with your phone number (stub)';

  @override
  String get phoneNumberLabel => 'Phone number';

  @override
  String get otpLabel => 'Code';

  @override
  String get continueLabel => 'Continue';

  @override
  String get unlockTitle => 'Unlock PROS.TO';

  @override
  String get unlockSubtitle => 'Use biometrics to continue';

  @override
  String get unlockAction => 'Unlock';

  @override
  String get unlockReason => 'Authenticate to unlock PROS.TO';

  @override
  String get unlockDisableBiometrics => 'Disable biometrics';
}
