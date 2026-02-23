// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => 'Suivi des composants et de l’équipement vélo';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => 'Suivez votre vélo. Connaissez votre équipement.';

  @override
  String get aboutDescription =>
      'PROS.TO est une application de cyclisme premium conçue pour les cyclistes qui prennent soin de leur matériel.\nSuivez le kilométrage et l’usure de chaque composant, conservez l’historique des remplacements et comprenez le coût réel de votre configuration.\nInterface sombre et minimaliste avec des accents métalliques chauds pour la clarté et la concentration.\n\nFonctionnalités clés :\n• Garage de vélos avec photos et valeur\n• Suivi du kilométrage et de l’usure des composants\n• Historique des remplacements et analyse des coûts\n• Inventaire d’équipement (casques, chaussures, tenues et plus)\n• Fonctionnement hors ligne\n• Verrouillage Face ID / Touch ID\n• Prise en charge des langues : anglais, ukrainien, espagnol, français, italien et chinois simplifié\n\nPROS.TO Pro :\n• Synchronisation Strava (mises à jour automatiques du kilométrage)\n• Vélos et composants illimités';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get homeTab => 'Accueil';

  @override
  String get garageTitle => 'Garage';

  @override
  String get garageTab => 'Garage';

  @override
  String get wardrobeTitle => 'Équipement';

  @override
  String get wardrobeTab => 'Matériel';

  @override
  String get insightsTitle => 'Analyses';

  @override
  String get insightsTab => 'Analyses';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsTab => 'Réglages';

  @override
  String get lastSyncTitle => 'Dernière synchro';

  @override
  String get lastSyncNever => 'Jamais synchronisé';

  @override
  String get addReplacement => 'Ajouter un remplacement';

  @override
  String get syncStrava => 'Synchroniser Strava';

  @override
  String get syncingStrava => 'Synchronisation...';

  @override
  String get fullSyncStrava => 'Synchronisation complète';

  @override
  String get fullSyncConfirmTitle => 'Synchronisation complète Strava';

  @override
  String get fullSyncConfirmBody =>
      'Ceci importera tous les vélos Strava et synchronisera leur kilométrage total.';

  @override
  String get fullSyncConfirmAction => 'Tout synchroniser';

  @override
  String get fullSyncCancelAction => 'Annuler';

  @override
  String get connectedStatus => 'Connecté';

  @override
  String get disconnectedStatus => 'Non connecté';

  @override
  String get proOnlyStatus => 'Pro uniquement';

  @override
  String get adjustBikeKm => 'Ajuster le kilométrage';

  @override
  String currentTotalKmLabel(Object km) {
    return 'Total actuel : $km km';
  }

  @override
  String get addKmLabel => 'Ajouter km';

  @override
  String get setTotalKmLabel => 'Définir le km total';

  @override
  String get adjustComponentKm => 'Ajuster le kilométrage du composant';

  @override
  String get componentKmLabel => 'Km du composant depuis l’installation';

  @override
  String get yourBikes => 'Vos vélos';

  @override
  String get emptyGarageTitle => 'Aucun vélo pour l’instant';

  @override
  String get emptyGarageSubtitle =>
      'Ajoutez votre premier vélo pour commencer à suivre les composants.';

  @override
  String get addBike => 'Ajouter un vélo';

  @override
  String totalKmLabel(Object km) {
    return '$km km au total';
  }

  @override
  String get noComponentsYet => 'Aucun composant pour l’instant';

  @override
  String get alertsTitle => 'Alertes d’entretien';

  @override
  String get alertsEmpty =>
      'Aucun composant ne nécessite d’attention pour l’instant.';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return 'Alerte principale : $brand $model • $wearPercent%';
  }

  @override
  String get statusOk => 'OK';

  @override
  String get statusWatch => 'Surveiller';

  @override
  String get statusReplace => 'Remplacer bientôt';

  @override
  String get statusReplaceNow => 'Remplacer maintenant';

  @override
  String get alertTitleWatch => 'Surveillance d’entretien';

  @override
  String get alertTitleReplace => 'Remplacement nécessaire';

  @override
  String alertBodyWatch(Object component, Object bike, Object wear) {
    return '$component sur $bike est à $wear% d’usure.';
  }

  @override
  String alertBodyReplace(Object component, Object bike, Object wear) {
    return '$component sur $bike est à $wear% d’usure. Remplacez bientôt.';
  }

  @override
  String alertBodyReplaceNow(Object component, Object bike, Object wear) {
    return '$component sur $bike est à $wear% d’usure. Remplacez maintenant.';
  }

  @override
  String get selectBike => 'Sélectionner un vélo';

  @override
  String get selectComponent => 'Sélectionner un composant';

  @override
  String syncSuccess(Object added, Object summary) {
    return 'Importé $added activités • $summary';
  }

  @override
  String get bikeDetailTitle => 'Détail du vélo';

  @override
  String get bikeNotFound => 'Vélo introuvable';

  @override
  String get componentsTitle => 'Composants';

  @override
  String get addComponent => 'Ajouter un composant';

  @override
  String get categoryDrivetrain => 'Transmission';

  @override
  String get categoryWheelsTires => 'Roues et pneus';

  @override
  String get categoryBrakes => 'Freins';

  @override
  String get categoryCockpit => 'Cockpit';

  @override
  String get categoryOther => 'Autres';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '$km km depuis l’installation • durée de vie $expected km';
  }

  @override
  String purchasePriceLabel(Object price) {
    return 'Prix d’achat : $price';
  }

  @override
  String get componentType => 'Type de composant';

  @override
  String get componentTypeChain => 'Chaîne';

  @override
  String get componentTypeCassette => 'Cassette';

  @override
  String get componentTypeChainring => 'Plateau';

  @override
  String get componentTypePowerMeter => 'Capteur de puissance';

  @override
  String get componentTypeShifters => 'Leviers de vitesse';

  @override
  String get componentTypeRearDerailleur => 'Dérailleur arrière';

  @override
  String get componentTypeFrontDerailleur => 'Dérailleur avant';

  @override
  String get componentTypeWheels => 'Roues';

  @override
  String get componentTypeTires => 'Pneus';

  @override
  String get componentTypeBrakes => 'Freins';

  @override
  String get componentTypeCockpit => 'Guidon';

  @override
  String get componentTypeStem => 'Potence';

  @override
  String get componentTypeBarTape => 'Guidoline';

  @override
  String get componentTypePedals => 'Pédales';

  @override
  String get componentTypeSaddle => 'Selle';

  @override
  String get componentTypeOther => 'Autre';

  @override
  String get brandLabel => 'Marque';

  @override
  String get modelLabel => 'Modèle';

  @override
  String get componentNameLabel => 'Nom du composant';

  @override
  String get componentDetailsOptionalLabel => 'Détails (facultatif)';

  @override
  String get expectedLifeLabel => 'Durée de vie estimée (km)';

  @override
  String get priceOptionalLabel => 'Prix (facultatif)';

  @override
  String get saveLabel => 'Enregistrer';

  @override
  String installedAtKm(Object km) {
    return 'Installé à $km km';
  }

  @override
  String get editBike => 'Modifier le vélo';

  @override
  String get bikeNameLabel => 'Nom du vélo';

  @override
  String get requiredField => 'Requis';

  @override
  String get purchasePriceOptional => 'Prix d’achat (facultatif)';

  @override
  String get deleteBike => 'Supprimer le vélo';

  @override
  String get bikePhotoLabel => 'Photo du vélo';

  @override
  String get pickPhoto => 'Touchez pour choisir une photo';

  @override
  String get photoPickerUnavailable =>
      'Le sélecteur de photos n’est pas disponible sur cette plateforme.';

  @override
  String get componentDetailTitle => 'Détail du composant';

  @override
  String get componentNotFound => 'Composant introuvable';

  @override
  String get replaceComponent => 'Remplacer le composant';

  @override
  String get replacementHistory => 'Historique des remplacements';

  @override
  String get noHistory => 'Aucun historique de remplacement pour l’instant';

  @override
  String removedAtKm(Object km) {
    return 'Retiré à $km km';
  }

  @override
  String get removalKmLabel => 'Compteur au retrait';

  @override
  String currentBikeKmLabel(Object km) {
    return 'Km actuels du vélo : $km';
  }

  @override
  String get newComponentTitle => 'Nouveau composant';

  @override
  String get totalGearValue => 'Valeur totale de l’équipement';

  @override
  String itemsCount(Object count) {
    return '$count articles';
  }

  @override
  String get categoryHelmets => 'Casques';

  @override
  String get categoryGlasses => 'Lunettes';

  @override
  String get categoryJerseys => 'Maillots';

  @override
  String get categoryBibs => 'Cuissards';

  @override
  String get categoryShoes => 'Chaussures';

  @override
  String get categoryGloves => 'Gants';

  @override
  String get categoryJackets => 'Vestes';

  @override
  String get categoryAccessories => 'Accessoires';

  @override
  String get emptyWardrobeCategory => 'Aucun article pour l’instant';

  @override
  String itemQuantity(Object quantity) {
    return 'Qté $quantity';
  }

  @override
  String get addItem => 'Ajouter un article';

  @override
  String get editItem => 'Modifier l’article';

  @override
  String get quantityLabel => 'Quantité';

  @override
  String get notesLabel => 'Notes';

  @override
  String get deleteItem => 'Supprimer l’article';

  @override
  String get totalBikeValue => 'Valeur totale des vélos';

  @override
  String totalKmAllBikes(Object km) {
    return 'Distance totale : $km km';
  }

  @override
  String totalGearValueLabel(Object value) {
    return 'Valeur totale de l’équipement : $value';
  }

  @override
  String get perBikeBreakdown => 'Détail par vélo';

  @override
  String bikeValueLabel(Object value) {
    return 'Valeur du vélo : $value';
  }

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageProOnlyHint =>
      'Langues supplémentaires disponibles avec PROS.TO Pro.';

  @override
  String get currencyTitle => 'Devise';

  @override
  String get currencyProOnlyHint => 'Disponible avec PROS.TO Pro.';

  @override
  String get currencyUsd => 'Dollar américain (\$)';

  @override
  String get currencyEur => 'Euro (€)';

  @override
  String get currencyGbp => 'Livre sterling (£)';

  @override
  String get currencyJpy => 'Yen japonais (¥)';

  @override
  String get currencyChf => 'Franc suisse (CHF)';

  @override
  String get currencyCny => 'Yuan chinois (¥)';

  @override
  String get currencyHkd => 'Dollar de Hong Kong (HK\$)';

  @override
  String get currencySgd => 'Dollar de Singapour (S\$)';

  @override
  String get currencyKrw => 'Won sud-coréen (₩)';

  @override
  String get currencyInr => 'Roupie indienne (₹)';

  @override
  String get currencyThb => 'Baht thaïlandais (฿)';

  @override
  String get currencyIdr => 'Roupie indonésienne (Rp)';

  @override
  String get currencyMyr => 'Ringgit malaisien (RM)';

  @override
  String get currencyPhp => 'Peso philippin (₱)';

  @override
  String get currencyCad => 'Dollar canadien (CA\$)';

  @override
  String get currencyAud => 'Dollar australien (A\$)';

  @override
  String get currencyNzd => 'Dollar néo-zélandais (NZ\$)';

  @override
  String get currencyMxn => 'Peso mexicain (MX\$)';

  @override
  String get currencyBrl => 'Réal brésilien (R\$)';

  @override
  String get currencyArs => 'Peso argentin (AR\$)';

  @override
  String get currencyClp => 'Peso chilien (CLP\$)';

  @override
  String get currencyCop => 'Peso colombien (COP\$)';

  @override
  String get currencyPln => 'Złoty polonais (zł)';

  @override
  String get currencyCzk => 'Couronne tchèque (Kč)';

  @override
  String get currencyHuf => 'Forint hongrois (Ft)';

  @override
  String get currencySek => 'Couronne suédoise (SEK)';

  @override
  String get currencyNok => 'Couronne norvégienne (NOK)';

  @override
  String get currencyDkk => 'Couronne danoise (DKK)';

  @override
  String get currencyRon => 'Leu roumain (RON)';

  @override
  String get currencyUah => 'Hryvnia ukrainienne (₴)';

  @override
  String get currencyTry => 'Livre turque (₺)';

  @override
  String get currencyAed => 'Dirham des ÉAU (AED)';

  @override
  String get currencySar => 'Riyal saoudien (SAR)';

  @override
  String get currencyIls => 'Nouveau shekel israélien (₪)';

  @override
  String get currencyZar => 'Rand sud-africain (ZAR)';

  @override
  String get currencyEgp => 'Livre égyptienne (EGP)';

  @override
  String get currencyNgn => 'Naira nigériane (NGN)';

  @override
  String get primaryBikeTitle => 'Vélo principal';

  @override
  String get primaryBikeLabel => 'Sélectionner le vélo principal';

  @override
  String get primaryBikeNone => 'Aucun vélo principal';

  @override
  String get primaryBikeEmpty =>
      'Ajoutez un vélo pour choisir un vélo principal.';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageUkrainian => 'Ukrainien';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageItalian => 'Italien';

  @override
  String get languageChinese => 'Chinois (simplifié)';

  @override
  String get biometricToggleTitle => 'Déverrouillage FaceID/TouchID';

  @override
  String get biometricToggleSubtitle => 'Exiger la biométrie au lancement';

  @override
  String get subscriptionTitle => 'Abonnement';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => 'Gratuit';

  @override
  String get upgradeToPro => 'Passer à Pro';

  @override
  String get cancelPro => 'Annuler Pro';

  @override
  String get proRequiredMessage => 'Disponible avec PROS.TO Pro.';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava connecté';

  @override
  String get stravaDisconnected => 'Strava non connecté';

  @override
  String get stravaLocked => 'La synchronisation Strava est Pro uniquement';

  @override
  String get stravaConnectRequired => 'Connectez Strava pour synchroniser.';

  @override
  String get stravaSessionExpired =>
      'La session Strava a expiré. Reconnectez-vous.';

  @override
  String get stravaSyncFailed =>
      'La synchronisation Strava a échoué. Réessayez.';

  @override
  String get stravaAuthFailed => 'Impossible d’ouvrir Strava. Réessayez.';

  @override
  String get stravaImporting => 'Importation des vélos Strava...';

  @override
  String get stravaImportBikes => 'Importer des vélos Strava';

  @override
  String get stravaImportFailed => 'L’import Strava a échoué. Réessayez.';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return 'Importés $added, liés $linked, ignorés $skipped.';
  }

  @override
  String get connectStrava => 'Connecter Strava';

  @override
  String get disconnectStrava => 'Déconnecter Strava';

  @override
  String get accountTitle => 'Compte';

  @override
  String get phoneAuthStub => 'La connexion par téléphone arrive bientôt.';

  @override
  String get openAuth => 'Ouvrir la connexion';

  @override
  String get aboutTitle => 'À propos';

  @override
  String versionLabel(Object version) {
    return 'Version $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle =>
      'Débloquez des fonctions premium de maintenance et de synchronisation.';

  @override
  String get proBenefitStrava => 'Synchronisation Strava';

  @override
  String get proBenefitUnlimited => 'Vélos et composants illimités';

  @override
  String get proBenefitAlerts => 'Alertes de maintenance intelligentes';

  @override
  String get proPrice => '\$5 / mois';

  @override
  String get proPriceNote => 'Annulez à tout moment';

  @override
  String get startPro => 'Démarrer Pro';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get phoneAuthTitle => 'Inscription par téléphone';

  @override
  String get phoneAuthSubtitle =>
      'Connectez-vous avec votre numéro de téléphone (maquette)';

  @override
  String get phoneNumberLabel => 'Numéro de téléphone';

  @override
  String get otpLabel => 'Code';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get unlockTitle => 'Déverrouiller PROS.TO';

  @override
  String get unlockSubtitle => 'Utilisez la biométrie pour continuer';

  @override
  String get unlockAction => 'Déverrouiller';

  @override
  String get unlockReason => 'Authentifiez-vous pour déverrouiller PROS.TO';

  @override
  String get unlockDisableBiometrics => 'Désactiver la biométrie';
}
