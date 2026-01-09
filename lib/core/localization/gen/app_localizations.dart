import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PROS.TO'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bike components & gear tracker'**
  String get appSubtitle;

  /// No description provided for @brandSignature.
  ///
  /// In en, this message translates to:
  /// **'by PASUE'**
  String get brandSignature;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Track your bike. Know your gear.'**
  String get tagline;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'PROS.TO is a premium cycling app built for riders who care about their equipment.\nTrack mileage and wear for every bike component, keep replacement history, and understand the true cost of your setup.\nDesigned with a dark, minimal interface and warm metallic accents for clarity and focus.\n\nKey features:\n• Bike garage with photos and value\n• Component mileage & wear tracking\n• Replacement history and cost insights\n• Cycling gear wardrobe (helmets, shoes, kits and more)\n• Offline-first performance\n• Face ID / Touch ID app lock\n• English & Ukrainian language support\n\nPROS.TO Pro:\n• Strava sync (automatic mileage updates)\n• Unlimited bikes and components'**
  String get aboutDescription;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @garageTitle.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get garageTitle;

  /// No description provided for @wardrobeTitle.
  ///
  /// In en, this message translates to:
  /// **'Wardrobe'**
  String get wardrobeTitle;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @lastSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Last sync'**
  String get lastSyncTitle;

  /// No description provided for @lastSyncNever.
  ///
  /// In en, this message translates to:
  /// **'Never synced'**
  String get lastSyncNever;

  /// No description provided for @addReplacement.
  ///
  /// In en, this message translates to:
  /// **'Add replacement'**
  String get addReplacement;

  /// No description provided for @syncStrava.
  ///
  /// In en, this message translates to:
  /// **'Sync Strava'**
  String get syncStrava;

  /// No description provided for @syncingStrava.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncingStrava;

  /// No description provided for @fullSyncStrava.
  ///
  /// In en, this message translates to:
  /// **'Full sync'**
  String get fullSyncStrava;

  /// No description provided for @fullSyncConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Full sync Strava'**
  String get fullSyncConfirmTitle;

  /// No description provided for @fullSyncConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This will import all Strava bikes and synchronize their total mileage.'**
  String get fullSyncConfirmBody;

  /// No description provided for @fullSyncConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Sync all'**
  String get fullSyncConfirmAction;

  /// No description provided for @fullSyncCancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get fullSyncCancelAction;

  /// No description provided for @connectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connectedStatus;

  /// No description provided for @disconnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get disconnectedStatus;

  /// No description provided for @proOnlyStatus.
  ///
  /// In en, this message translates to:
  /// **'Pro-only'**
  String get proOnlyStatus;

  /// No description provided for @adjustBikeKm.
  ///
  /// In en, this message translates to:
  /// **'Adjust mileage'**
  String get adjustBikeKm;

  /// No description provided for @currentTotalKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Current total: {km} km'**
  String currentTotalKmLabel(Object km);

  /// No description provided for @addKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Add km'**
  String get addKmLabel;

  /// No description provided for @setTotalKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Set total km'**
  String get setTotalKmLabel;

  /// No description provided for @adjustComponentKm.
  ///
  /// In en, this message translates to:
  /// **'Adjust component mileage'**
  String get adjustComponentKm;

  /// No description provided for @componentKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Component km since install'**
  String get componentKmLabel;

  /// No description provided for @yourBikes.
  ///
  /// In en, this message translates to:
  /// **'Your bikes'**
  String get yourBikes;

  /// No description provided for @emptyGarageTitle.
  ///
  /// In en, this message translates to:
  /// **'No bikes yet'**
  String get emptyGarageTitle;

  /// No description provided for @emptyGarageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your first bike to start tracking components.'**
  String get emptyGarageSubtitle;

  /// No description provided for @addBike.
  ///
  /// In en, this message translates to:
  /// **'Add bike'**
  String get addBike;

  /// No description provided for @totalKmLabel.
  ///
  /// In en, this message translates to:
  /// **'{km} km total'**
  String totalKmLabel(Object km);

  /// No description provided for @noComponentsYet.
  ///
  /// In en, this message translates to:
  /// **'No components yet'**
  String get noComponentsYet;

  /// No description provided for @alertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Maintenance alerts'**
  String get alertsTitle;

  /// No description provided for @alertsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No components need attention yet.'**
  String get alertsEmpty;

  /// No description provided for @topAlertLabel.
  ///
  /// In en, this message translates to:
  /// **'Top alert: {brand} {model} • {wearPercent}%'**
  String topAlertLabel(Object brand, Object model, Object wearPercent);

  /// No description provided for @statusOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get statusOk;

  /// No description provided for @statusWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get statusWatch;

  /// No description provided for @statusReplace.
  ///
  /// In en, this message translates to:
  /// **'Replace soon'**
  String get statusReplace;

  /// No description provided for @statusReplaceNow.
  ///
  /// In en, this message translates to:
  /// **'Replace now'**
  String get statusReplaceNow;

  /// No description provided for @alertTitleWatch.
  ///
  /// In en, this message translates to:
  /// **'Maintenance watch'**
  String get alertTitleWatch;

  /// No description provided for @alertTitleReplace.
  ///
  /// In en, this message translates to:
  /// **'Replacement needed'**
  String get alertTitleReplace;

  /// No description provided for @alertBodyWatch.
  ///
  /// In en, this message translates to:
  /// **'{component} on {bike} is at {wear}% wear.'**
  String alertBodyWatch(Object component, Object bike, Object wear);

  /// No description provided for @alertBodyReplace.
  ///
  /// In en, this message translates to:
  /// **'{component} on {bike} is at {wear}% wear. Replace soon.'**
  String alertBodyReplace(Object component, Object bike, Object wear);

  /// No description provided for @alertBodyReplaceNow.
  ///
  /// In en, this message translates to:
  /// **'{component} on {bike} is at {wear}% wear. Replace now.'**
  String alertBodyReplaceNow(Object component, Object bike, Object wear);

  /// No description provided for @selectBike.
  ///
  /// In en, this message translates to:
  /// **'Select bike'**
  String get selectBike;

  /// No description provided for @selectComponent.
  ///
  /// In en, this message translates to:
  /// **'Select component'**
  String get selectComponent;

  /// No description provided for @syncSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported {added} rides • {summary}'**
  String syncSuccess(Object added, Object summary);

  /// No description provided for @bikeDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Bike detail'**
  String get bikeDetailTitle;

  /// No description provided for @bikeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Bike not found'**
  String get bikeNotFound;

  /// No description provided for @componentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get componentsTitle;

  /// No description provided for @addComponent.
  ///
  /// In en, this message translates to:
  /// **'Add component'**
  String get addComponent;

  /// No description provided for @categoryDrivetrain.
  ///
  /// In en, this message translates to:
  /// **'Drivetrain'**
  String get categoryDrivetrain;

  /// No description provided for @categoryWheelsTires.
  ///
  /// In en, this message translates to:
  /// **'Wheels & Tires'**
  String get categoryWheelsTires;

  /// No description provided for @categoryBrakes.
  ///
  /// In en, this message translates to:
  /// **'Brakes'**
  String get categoryBrakes;

  /// No description provided for @categoryCockpit.
  ///
  /// In en, this message translates to:
  /// **'Cockpit'**
  String get categoryCockpit;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @kmSinceInstall.
  ///
  /// In en, this message translates to:
  /// **'{km} km since install • {expected} km life'**
  String kmSinceInstall(Object km, Object expected);

  /// No description provided for @purchasePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase price: {price}'**
  String purchasePriceLabel(Object price);

  /// No description provided for @componentType.
  ///
  /// In en, this message translates to:
  /// **'Component type'**
  String get componentType;

  /// No description provided for @componentTypeChain.
  ///
  /// In en, this message translates to:
  /// **'Chain'**
  String get componentTypeChain;

  /// No description provided for @componentTypeCassette.
  ///
  /// In en, this message translates to:
  /// **'Cassette'**
  String get componentTypeCassette;

  /// No description provided for @componentTypeChainring.
  ///
  /// In en, this message translates to:
  /// **'Chainring'**
  String get componentTypeChainring;

  /// No description provided for @componentTypePowerMeter.
  ///
  /// In en, this message translates to:
  /// **'Power meter'**
  String get componentTypePowerMeter;

  /// No description provided for @componentTypeShifters.
  ///
  /// In en, this message translates to:
  /// **'Shifters'**
  String get componentTypeShifters;

  /// No description provided for @componentTypeRearDerailleur.
  ///
  /// In en, this message translates to:
  /// **'Rear derailleur'**
  String get componentTypeRearDerailleur;

  /// No description provided for @componentTypeFrontDerailleur.
  ///
  /// In en, this message translates to:
  /// **'Front derailleur'**
  String get componentTypeFrontDerailleur;

  /// No description provided for @componentTypeWheels.
  ///
  /// In en, this message translates to:
  /// **'Wheels'**
  String get componentTypeWheels;

  /// No description provided for @componentTypeTires.
  ///
  /// In en, this message translates to:
  /// **'Tires'**
  String get componentTypeTires;

  /// No description provided for @componentTypeBrakes.
  ///
  /// In en, this message translates to:
  /// **'Brakes'**
  String get componentTypeBrakes;

  /// No description provided for @componentTypeCockpit.
  ///
  /// In en, this message translates to:
  /// **'Handlebar'**
  String get componentTypeCockpit;

  /// No description provided for @componentTypeStem.
  ///
  /// In en, this message translates to:
  /// **'Stem'**
  String get componentTypeStem;

  /// No description provided for @componentTypeBarTape.
  ///
  /// In en, this message translates to:
  /// **'Handlebar tape'**
  String get componentTypeBarTape;

  /// No description provided for @componentTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get componentTypeOther;

  /// No description provided for @brandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brandLabel;

  /// No description provided for @modelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get modelLabel;

  /// No description provided for @componentNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Component name'**
  String get componentNameLabel;

  /// No description provided for @componentDetailsOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get componentDetailsOptionalLabel;

  /// No description provided for @expectedLifeLabel.
  ///
  /// In en, this message translates to:
  /// **'Expected life (km)'**
  String get expectedLifeLabel;

  /// No description provided for @priceOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Price (optional)'**
  String get priceOptionalLabel;

  /// No description provided for @saveLabel.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveLabel;

  /// No description provided for @installedAtKm.
  ///
  /// In en, this message translates to:
  /// **'Installed at {km} km'**
  String installedAtKm(Object km);

  /// No description provided for @editBike.
  ///
  /// In en, this message translates to:
  /// **'Edit bike'**
  String get editBike;

  /// No description provided for @bikeNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Bike name'**
  String get bikeNameLabel;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredField;

  /// No description provided for @purchasePriceOptional.
  ///
  /// In en, this message translates to:
  /// **'Purchase price (optional)'**
  String get purchasePriceOptional;

  /// No description provided for @deleteBike.
  ///
  /// In en, this message translates to:
  /// **'Delete bike'**
  String get deleteBike;

  /// No description provided for @bikePhotoLabel.
  ///
  /// In en, this message translates to:
  /// **'Bike photo'**
  String get bikePhotoLabel;

  /// No description provided for @pickPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to pick a photo'**
  String get pickPhoto;

  /// No description provided for @photoPickerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photo picker is not available on this platform.'**
  String get photoPickerUnavailable;

  /// No description provided for @componentDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Component detail'**
  String get componentDetailTitle;

  /// No description provided for @componentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Component not found'**
  String get componentNotFound;

  /// No description provided for @replaceComponent.
  ///
  /// In en, this message translates to:
  /// **'Replace component'**
  String get replaceComponent;

  /// No description provided for @replacementHistory.
  ///
  /// In en, this message translates to:
  /// **'Replacement history'**
  String get replacementHistory;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No replacement history yet'**
  String get noHistory;

  /// No description provided for @removedAtKm.
  ///
  /// In en, this message translates to:
  /// **'Removed at {km} km'**
  String removedAtKm(Object km);

  /// No description provided for @removalKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Removal odometer'**
  String get removalKmLabel;

  /// No description provided for @currentBikeKmLabel.
  ///
  /// In en, this message translates to:
  /// **'Current bike km: {km}'**
  String currentBikeKmLabel(Object km);

  /// No description provided for @newComponentTitle.
  ///
  /// In en, this message translates to:
  /// **'New component'**
  String get newComponentTitle;

  /// No description provided for @totalGearValue.
  ///
  /// In en, this message translates to:
  /// **'Total gear value'**
  String get totalGearValue;

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemsCount(Object count);

  /// No description provided for @categoryHelmets.
  ///
  /// In en, this message translates to:
  /// **'Helmets'**
  String get categoryHelmets;

  /// No description provided for @categoryGlasses.
  ///
  /// In en, this message translates to:
  /// **'Glasses'**
  String get categoryGlasses;

  /// No description provided for @categoryJerseys.
  ///
  /// In en, this message translates to:
  /// **'Jerseys'**
  String get categoryJerseys;

  /// No description provided for @categoryBibs.
  ///
  /// In en, this message translates to:
  /// **'Bibs'**
  String get categoryBibs;

  /// No description provided for @categoryShoes.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get categoryShoes;

  /// No description provided for @categoryGloves.
  ///
  /// In en, this message translates to:
  /// **'Gloves'**
  String get categoryGloves;

  /// No description provided for @categoryJackets.
  ///
  /// In en, this message translates to:
  /// **'Jackets'**
  String get categoryJackets;

  /// No description provided for @categoryAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get categoryAccessories;

  /// No description provided for @emptyWardrobeCategory.
  ///
  /// In en, this message translates to:
  /// **'No items yet'**
  String get emptyWardrobeCategory;

  /// No description provided for @itemQuantity.
  ///
  /// In en, this message translates to:
  /// **'Qty {quantity}'**
  String itemQuantity(Object quantity);

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get addItem;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit item'**
  String get editItem;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantityLabel;

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @deleteItem.
  ///
  /// In en, this message translates to:
  /// **'Delete item'**
  String get deleteItem;

  /// No description provided for @totalBikeValue.
  ///
  /// In en, this message translates to:
  /// **'Total bike value'**
  String get totalBikeValue;

  /// No description provided for @totalKmAllBikes.
  ///
  /// In en, this message translates to:
  /// **'Total distance: {km} km'**
  String totalKmAllBikes(Object km);

  /// No description provided for @totalGearValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Total gear value: {value}'**
  String totalGearValueLabel(Object value);

  /// No description provided for @perBikeBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Per-bike breakdown'**
  String get perBikeBreakdown;

  /// No description provided for @bikeValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Bike value: {value}'**
  String bikeValueLabel(Object value);

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @currencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyTitle;

  /// No description provided for @currencyProOnlyHint.
  ///
  /// In en, this message translates to:
  /// **'Available with PROS.TO Pro.'**
  String get currencyProOnlyHint;

  /// No description provided for @currencyUsd.
  ///
  /// In en, this message translates to:
  /// **'US Dollar (\$)'**
  String get currencyUsd;

  /// No description provided for @currencyEur.
  ///
  /// In en, this message translates to:
  /// **'Euro (€)'**
  String get currencyEur;

  /// No description provided for @currencyGbp.
  ///
  /// In en, this message translates to:
  /// **'British Pound Sterling (£)'**
  String get currencyGbp;

  /// No description provided for @currencyJpy.
  ///
  /// In en, this message translates to:
  /// **'Japanese Yen (¥)'**
  String get currencyJpy;

  /// No description provided for @currencyChf.
  ///
  /// In en, this message translates to:
  /// **'Swiss Franc (CHF)'**
  String get currencyChf;

  /// No description provided for @currencyCny.
  ///
  /// In en, this message translates to:
  /// **'Chinese Yuan (¥)'**
  String get currencyCny;

  /// No description provided for @currencyHkd.
  ///
  /// In en, this message translates to:
  /// **'Hong Kong Dollar (HK\$)'**
  String get currencyHkd;

  /// No description provided for @currencySgd.
  ///
  /// In en, this message translates to:
  /// **'Singapore Dollar (S\$)'**
  String get currencySgd;

  /// No description provided for @currencyKrw.
  ///
  /// In en, this message translates to:
  /// **'South Korean Won (₩)'**
  String get currencyKrw;

  /// No description provided for @currencyInr.
  ///
  /// In en, this message translates to:
  /// **'Indian Rupee (₹)'**
  String get currencyInr;

  /// No description provided for @currencyThb.
  ///
  /// In en, this message translates to:
  /// **'Thai Baht (฿)'**
  String get currencyThb;

  /// No description provided for @currencyIdr.
  ///
  /// In en, this message translates to:
  /// **'Indonesian Rupiah (Rp)'**
  String get currencyIdr;

  /// No description provided for @currencyMyr.
  ///
  /// In en, this message translates to:
  /// **'Malaysian Ringgit (RM)'**
  String get currencyMyr;

  /// No description provided for @currencyPhp.
  ///
  /// In en, this message translates to:
  /// **'Philippine Peso (₱)'**
  String get currencyPhp;

  /// No description provided for @currencyCad.
  ///
  /// In en, this message translates to:
  /// **'Canadian Dollar (CA\$)'**
  String get currencyCad;

  /// No description provided for @currencyAud.
  ///
  /// In en, this message translates to:
  /// **'Australian Dollar (A\$)'**
  String get currencyAud;

  /// No description provided for @currencyNzd.
  ///
  /// In en, this message translates to:
  /// **'New Zealand Dollar (NZ\$)'**
  String get currencyNzd;

  /// No description provided for @currencyMxn.
  ///
  /// In en, this message translates to:
  /// **'Mexican Peso (MX\$)'**
  String get currencyMxn;

  /// No description provided for @currencyBrl.
  ///
  /// In en, this message translates to:
  /// **'Brazilian Real (R\$)'**
  String get currencyBrl;

  /// No description provided for @currencyArs.
  ///
  /// In en, this message translates to:
  /// **'Argentine Peso (AR\$)'**
  String get currencyArs;

  /// No description provided for @currencyClp.
  ///
  /// In en, this message translates to:
  /// **'Chilean Peso (CLP\$)'**
  String get currencyClp;

  /// No description provided for @currencyCop.
  ///
  /// In en, this message translates to:
  /// **'Colombian Peso (COP\$)'**
  String get currencyCop;

  /// No description provided for @currencyPln.
  ///
  /// In en, this message translates to:
  /// **'Polish Zloty (zł)'**
  String get currencyPln;

  /// No description provided for @currencyCzk.
  ///
  /// In en, this message translates to:
  /// **'Czech Koruna (Kč)'**
  String get currencyCzk;

  /// No description provided for @currencyHuf.
  ///
  /// In en, this message translates to:
  /// **'Hungarian Forint (Ft)'**
  String get currencyHuf;

  /// No description provided for @currencySek.
  ///
  /// In en, this message translates to:
  /// **'Swedish Krona (SEK)'**
  String get currencySek;

  /// No description provided for @currencyNok.
  ///
  /// In en, this message translates to:
  /// **'Norwegian Krone (NOK)'**
  String get currencyNok;

  /// No description provided for @currencyDkk.
  ///
  /// In en, this message translates to:
  /// **'Danish Krone (DKK)'**
  String get currencyDkk;

  /// No description provided for @currencyRon.
  ///
  /// In en, this message translates to:
  /// **'Romanian Leu (RON)'**
  String get currencyRon;

  /// No description provided for @currencyUah.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian Hryvnia (₴)'**
  String get currencyUah;

  /// No description provided for @currencyTry.
  ///
  /// In en, this message translates to:
  /// **'Turkish Lira (₺)'**
  String get currencyTry;

  /// No description provided for @currencyAed.
  ///
  /// In en, this message translates to:
  /// **'UAE Dirham (AED)'**
  String get currencyAed;

  /// No description provided for @currencySar.
  ///
  /// In en, this message translates to:
  /// **'Saudi Riyal (SAR)'**
  String get currencySar;

  /// No description provided for @currencyIls.
  ///
  /// In en, this message translates to:
  /// **'Israeli New Shekel (₪)'**
  String get currencyIls;

  /// No description provided for @currencyZar.
  ///
  /// In en, this message translates to:
  /// **'South African Rand (ZAR)'**
  String get currencyZar;

  /// No description provided for @currencyEgp.
  ///
  /// In en, this message translates to:
  /// **'Egyptian Pound (EGP)'**
  String get currencyEgp;

  /// No description provided for @currencyNgn.
  ///
  /// In en, this message translates to:
  /// **'Nigerian Naira (NGN)'**
  String get currencyNgn;

  /// No description provided for @primaryBikeTitle.
  ///
  /// In en, this message translates to:
  /// **'Primary bike'**
  String get primaryBikeTitle;

  /// No description provided for @primaryBikeLabel.
  ///
  /// In en, this message translates to:
  /// **'Select primary bike'**
  String get primaryBikeLabel;

  /// No description provided for @primaryBikeNone.
  ///
  /// In en, this message translates to:
  /// **'No primary bike'**
  String get primaryBikeNone;

  /// No description provided for @primaryBikeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add a bike to choose a primary one.'**
  String get primaryBikeEmpty;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageUkrainian.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get languageUkrainian;

  /// No description provided for @biometricToggleTitle.
  ///
  /// In en, this message translates to:
  /// **'FaceID/TouchID unlock'**
  String get biometricToggleTitle;

  /// No description provided for @biometricToggleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require biometrics on launch'**
  String get biometricToggleSubtitle;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscriptionTitle;

  /// No description provided for @proStatus.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get proStatus;

  /// No description provided for @freeStatus.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get freeStatus;

  /// No description provided for @upgradeToPro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get upgradeToPro;

  /// No description provided for @cancelPro.
  ///
  /// In en, this message translates to:
  /// **'Cancel Pro'**
  String get cancelPro;

  /// No description provided for @proRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Available with PROS.TO Pro.'**
  String get proRequiredMessage;

  /// No description provided for @stravaTitle.
  ///
  /// In en, this message translates to:
  /// **'Strava'**
  String get stravaTitle;

  /// No description provided for @stravaConnected.
  ///
  /// In en, this message translates to:
  /// **'Strava connected'**
  String get stravaConnected;

  /// No description provided for @stravaDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Strava not connected'**
  String get stravaDisconnected;

  /// No description provided for @stravaLocked.
  ///
  /// In en, this message translates to:
  /// **'Strava sync is Pro-only'**
  String get stravaLocked;

  /// No description provided for @stravaConnectRequired.
  ///
  /// In en, this message translates to:
  /// **'Connect Strava to sync.'**
  String get stravaConnectRequired;

  /// No description provided for @stravaSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Strava session expired. Please reconnect.'**
  String get stravaSessionExpired;

  /// No description provided for @stravaSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Strava sync failed. Try again.'**
  String get stravaSyncFailed;

  /// No description provided for @stravaAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to open Strava. Try again.'**
  String get stravaAuthFailed;

  /// No description provided for @stravaImporting.
  ///
  /// In en, this message translates to:
  /// **'Importing Strava bikes...'**
  String get stravaImporting;

  /// No description provided for @stravaImportBikes.
  ///
  /// In en, this message translates to:
  /// **'Import bikes from Strava'**
  String get stravaImportBikes;

  /// No description provided for @stravaImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Strava import failed. Try again.'**
  String get stravaImportFailed;

  /// No description provided for @stravaImportResult.
  ///
  /// In en, this message translates to:
  /// **'Imported {added}, linked {linked}, skipped {skipped}.'**
  String stravaImportResult(Object added, Object linked, Object skipped);

  /// No description provided for @connectStrava.
  ///
  /// In en, this message translates to:
  /// **'Connect Strava'**
  String get connectStrava;

  /// No description provided for @disconnectStrava.
  ///
  /// In en, this message translates to:
  /// **'Disconnect Strava'**
  String get disconnectStrava;

  /// No description provided for @accountTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountTitle;

  /// No description provided for @phoneAuthStub.
  ///
  /// In en, this message translates to:
  /// **'Phone login is coming soon.'**
  String get phoneAuthStub;

  /// No description provided for @openAuth.
  ///
  /// In en, this message translates to:
  /// **'Open login'**
  String get openAuth;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(Object version);

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'PROS.TO Pro'**
  String get paywallTitle;

  /// No description provided for @proTitle.
  ///
  /// In en, this message translates to:
  /// **'PROS.TO Pro'**
  String get proTitle;

  /// No description provided for @proSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock premium maintenance and sync features.'**
  String get proSubtitle;

  /// No description provided for @proBenefitStrava.
  ///
  /// In en, this message translates to:
  /// **'Strava sync'**
  String get proBenefitStrava;

  /// No description provided for @proBenefitUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited bikes & components'**
  String get proBenefitUnlimited;

  /// No description provided for @proBenefitAlerts.
  ///
  /// In en, this message translates to:
  /// **'Smart maintenance alerts'**
  String get proBenefitAlerts;

  /// No description provided for @proPrice.
  ///
  /// In en, this message translates to:
  /// **'\$5 / month'**
  String get proPrice;

  /// No description provided for @proPriceNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get proPriceNote;

  /// No description provided for @startPro.
  ///
  /// In en, this message translates to:
  /// **'Start Pro'**
  String get startPro;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @phoneAuthTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone registration'**
  String get phoneAuthTitle;

  /// No description provided for @phoneAuthSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your phone number (stub)'**
  String get phoneAuthSubtitle;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumberLabel;

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get otpLabel;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @unlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock PROS.TO'**
  String get unlockTitle;

  /// No description provided for @unlockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics to continue'**
  String get unlockSubtitle;

  /// No description provided for @unlockAction.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlockAction;

  /// No description provided for @unlockReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to unlock PROS.TO'**
  String get unlockReason;

  /// No description provided for @unlockDisableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Disable biometrics'**
  String get unlockDisableBiometrics;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
