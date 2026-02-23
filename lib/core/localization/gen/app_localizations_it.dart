// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => 'Tracciamento componenti e attrezzatura bici';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => 'Traccia la tua bici. Conosci la tua attrezzatura.';

  @override
  String get aboutDescription =>
      'PROS.TO è un’app premium di ciclismo pensata per chi tiene alla propria attrezzatura.\nTraccia il chilometraggio e l’usura di ogni componente, conserva la cronologia delle sostituzioni e capisci il costo reale della tua configurazione.\nInterfaccia scura e minimale con accenti metallici caldi per chiarezza e concentrazione.\n\nFunzionalità chiave:\n• Garage bici con foto e valore\n• Tracciamento chilometraggio e usura componenti\n• Cronologia sostituzioni e analisi dei costi\n• Inventario attrezzatura (caschi, scarpe, kit e altro)\n• Funzionamento offline\n• Blocco Face ID / Touch ID\n• Supporto lingue: inglese, ucraino, spagnolo, francese, italiano e cinese semplificato\n\nPROS.TO Pro:\n• Sincronizzazione Strava (aggiornamenti automatici del chilometraggio)\n• Bici e componenti illimitati';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeTab => 'Home';

  @override
  String get garageTitle => 'Garage';

  @override
  String get garageTab => 'Garage';

  @override
  String get wardrobeTitle => 'Attrezzatura';

  @override
  String get wardrobeTab => 'Kit';

  @override
  String get insightsTitle => 'Analisi';

  @override
  String get insightsTab => 'Analisi';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsTab => 'Impost.';

  @override
  String get lastSyncTitle => 'Ultima sincronizzazione';

  @override
  String get lastSyncNever => 'Mai sincronizzato';

  @override
  String get addReplacement => 'Aggiungi sostituzione';

  @override
  String get syncStrava => 'Sincronizza Strava';

  @override
  String get syncingStrava => 'Sincronizzazione...';

  @override
  String get fullSyncStrava => 'Sincronizzazione completa';

  @override
  String get fullSyncConfirmTitle => 'Sincronizzazione completa Strava';

  @override
  String get fullSyncConfirmBody =>
      'Questa azione importerà tutte le bici Strava e sincronizzerà il loro chilometraggio totale.';

  @override
  String get fullSyncConfirmAction => 'Sincronizza tutto';

  @override
  String get fullSyncCancelAction => 'Annulla';

  @override
  String get connectedStatus => 'Connesso';

  @override
  String get disconnectedStatus => 'Non connesso';

  @override
  String get proOnlyStatus => 'Solo Pro';

  @override
  String get adjustBikeKm => 'Regola chilometraggio';

  @override
  String currentTotalKmLabel(Object km) {
    return 'Totale attuale: $km km';
  }

  @override
  String get addKmLabel => 'Aggiungi km';

  @override
  String get setTotalKmLabel => 'Imposta km totali';

  @override
  String get adjustComponentKm => 'Regola chilometraggio componente';

  @override
  String get componentKmLabel => 'Km del componente dall’installazione';

  @override
  String get yourBikes => 'Le tue bici';

  @override
  String get emptyGarageTitle => 'Nessuna bici per ora';

  @override
  String get emptyGarageSubtitle =>
      'Aggiungi la tua prima bici per iniziare a tracciare i componenti.';

  @override
  String get addBike => 'Aggiungi bici';

  @override
  String totalKmLabel(Object km) {
    return '$km km totali';
  }

  @override
  String get noComponentsYet => 'Nessun componente ancora';

  @override
  String get alertsTitle => 'Avvisi di manutenzione';

  @override
  String get alertsEmpty => 'Nessun componente richiede attenzione per ora.';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return 'Avviso principale: $brand $model • $wearPercent%';
  }

  @override
  String get statusOk => 'OK';

  @override
  String get statusWatch => 'Monitorare';

  @override
  String get statusReplace => 'Sostituire presto';

  @override
  String get statusReplaceNow => 'Sostituire ora';

  @override
  String get alertTitleWatch => 'Monitoraggio manutenzione';

  @override
  String get alertTitleReplace => 'Sostituzione necessaria';

  @override
  String alertBodyWatch(Object component, Object bike, Object wear) {
    return '$component su $bike è al $wear% di usura.';
  }

  @override
  String alertBodyReplace(Object component, Object bike, Object wear) {
    return '$component su $bike è al $wear% di usura. Sostituisci presto.';
  }

  @override
  String alertBodyReplaceNow(Object component, Object bike, Object wear) {
    return '$component su $bike è al $wear% di usura. Sostituisci ora.';
  }

  @override
  String get selectBike => 'Seleziona bici';

  @override
  String get selectComponent => 'Seleziona componente';

  @override
  String syncSuccess(Object added, Object summary) {
    return 'Importate $added attività • $summary';
  }

  @override
  String get bikeDetailTitle => 'Dettaglio bici';

  @override
  String get bikeNotFound => 'Bici non trovata';

  @override
  String get componentsTitle => 'Componenti';

  @override
  String get addComponent => 'Aggiungi componente';

  @override
  String get categoryDrivetrain => 'Trasmissione';

  @override
  String get categoryWheelsTires => 'Ruote e pneumatici';

  @override
  String get categoryBrakes => 'Freni';

  @override
  String get categoryCockpit => 'Cockpit';

  @override
  String get categoryOther => 'Altro';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '$km km dall’installazione • durata $expected km';
  }

  @override
  String purchasePriceLabel(Object price) {
    return 'Prezzo d\'acquisto: $price';
  }

  @override
  String get componentType => 'Tipo componente';

  @override
  String get componentTypeChain => 'Catena';

  @override
  String get componentTypeCassette => 'Cassetta';

  @override
  String get componentTypeChainring => 'Corona';

  @override
  String get componentTypePowerMeter => 'Misuratore di potenza';

  @override
  String get componentTypeShifters => 'Comandi';

  @override
  String get componentTypeRearDerailleur => 'Deragliatore posteriore';

  @override
  String get componentTypeFrontDerailleur => 'Deragliatore anteriore';

  @override
  String get componentTypeWheels => 'Ruote';

  @override
  String get componentTypeTires => 'Pneumatici';

  @override
  String get componentTypeBrakes => 'Freni';

  @override
  String get componentTypeCockpit => 'Manubrio';

  @override
  String get componentTypeStem => 'Attacco manubrio';

  @override
  String get componentTypeBarTape => 'Nastro manubrio';

  @override
  String get componentTypePedals => 'Pedali';

  @override
  String get componentTypeSaddle => 'Sella';

  @override
  String get componentTypeOther => 'Altro';

  @override
  String get brandLabel => 'Marca';

  @override
  String get modelLabel => 'Modello';

  @override
  String get componentNameLabel => 'Nome componente';

  @override
  String get componentDetailsOptionalLabel => 'Dettagli (opzionale)';

  @override
  String get expectedLifeLabel => 'Durata prevista (km)';

  @override
  String get priceOptionalLabel => 'Prezzo (opzionale)';

  @override
  String get saveLabel => 'Salva';

  @override
  String installedAtKm(Object km) {
    return 'Installato a $km km';
  }

  @override
  String get editBike => 'Modifica bici';

  @override
  String get bikeNameLabel => 'Nome bici';

  @override
  String get requiredField => 'Obbligatorio';

  @override
  String get purchasePriceOptional => 'Prezzo d\'acquisto (opzionale)';

  @override
  String get deleteBike => 'Elimina bici';

  @override
  String get bikePhotoLabel => 'Foto bici';

  @override
  String get pickPhoto => 'Tocca per scegliere una foto';

  @override
  String get photoPickerUnavailable =>
      'Il selettore foto non è disponibile su questa piattaforma.';

  @override
  String get componentDetailTitle => 'Dettaglio componente';

  @override
  String get componentNotFound => 'Componente non trovato';

  @override
  String get replaceComponent => 'Sostituisci componente';

  @override
  String get replacementHistory => 'Cronologia sostituzioni';

  @override
  String get noHistory => 'Nessuna cronologia di sostituzioni';

  @override
  String removedAtKm(Object km) {
    return 'Rimosso a $km km';
  }

  @override
  String get removalKmLabel => 'Contachilometri alla rimozione';

  @override
  String currentBikeKmLabel(Object km) {
    return 'Km attuali della bici: $km';
  }

  @override
  String get newComponentTitle => 'Nuovo componente';

  @override
  String get totalGearValue => 'Valore totale attrezzatura';

  @override
  String itemsCount(Object count) {
    return '$count articoli';
  }

  @override
  String get categoryHelmets => 'Caschi';

  @override
  String get categoryGlasses => 'Occhiali';

  @override
  String get categoryJerseys => 'Maglie';

  @override
  String get categoryBibs => 'Salopette';

  @override
  String get categoryShoes => 'Scarpe';

  @override
  String get categoryGloves => 'Guanti';

  @override
  String get categoryJackets => 'Giacche';

  @override
  String get categoryAccessories => 'Accessori';

  @override
  String get emptyWardrobeCategory => 'Nessun articolo ancora';

  @override
  String itemQuantity(Object quantity) {
    return 'Qtà $quantity';
  }

  @override
  String get addItem => 'Aggiungi articolo';

  @override
  String get editItem => 'Modifica articolo';

  @override
  String get quantityLabel => 'Quantità';

  @override
  String get notesLabel => 'Note';

  @override
  String get deleteItem => 'Elimina articolo';

  @override
  String get totalBikeValue => 'Valore totale bici';

  @override
  String totalKmAllBikes(Object km) {
    return 'Distanza totale: $km km';
  }

  @override
  String totalGearValueLabel(Object value) {
    return 'Valore totale attrezzatura: $value';
  }

  @override
  String get perBikeBreakdown => 'Dettaglio per bici';

  @override
  String bikeValueLabel(Object value) {
    return 'Valore bici: $value';
  }

  @override
  String get languageTitle => 'Lingua';

  @override
  String get languageProOnlyHint =>
      'Lingue aggiuntive disponibili con PROS.TO Pro.';

  @override
  String get currencyTitle => 'Valuta';

  @override
  String get currencyProOnlyHint => 'Disponibile con PROS.TO Pro.';

  @override
  String get currencyUsd => 'Dollaro USA (\$)';

  @override
  String get currencyEur => 'Euro (€)';

  @override
  String get currencyGbp => 'Sterlina britannica (£)';

  @override
  String get currencyJpy => 'Yen giapponese (¥)';

  @override
  String get currencyChf => 'Franco svizzero (CHF)';

  @override
  String get currencyCny => 'Yuan cinese (¥)';

  @override
  String get currencyHkd => 'Dollaro di Hong Kong (HK\$)';

  @override
  String get currencySgd => 'Dollaro di Singapore (S\$)';

  @override
  String get currencyKrw => 'Won sudcoreano (₩)';

  @override
  String get currencyInr => 'Rupia indiana (₹)';

  @override
  String get currencyThb => 'Baht thailandese (฿)';

  @override
  String get currencyIdr => 'Rupia indonesiana (Rp)';

  @override
  String get currencyMyr => 'Ringgit malese (RM)';

  @override
  String get currencyPhp => 'Peso filippino (₱)';

  @override
  String get currencyCad => 'Dollaro canadese (CA\$)';

  @override
  String get currencyAud => 'Dollaro australiano (A\$)';

  @override
  String get currencyNzd => 'Dollaro neozelandese (NZ\$)';

  @override
  String get currencyMxn => 'Peso messicano (MX\$)';

  @override
  String get currencyBrl => 'Real brasiliano (R\$)';

  @override
  String get currencyArs => 'Peso argentino (AR\$)';

  @override
  String get currencyClp => 'Peso cileno (CLP\$)';

  @override
  String get currencyCop => 'Peso colombiano (COP\$)';

  @override
  String get currencyPln => 'Złoty polacco (zł)';

  @override
  String get currencyCzk => 'Corona ceca (Kč)';

  @override
  String get currencyHuf => 'Fiorino ungherese (Ft)';

  @override
  String get currencySek => 'Corona svedese (SEK)';

  @override
  String get currencyNok => 'Corona norvegese (NOK)';

  @override
  String get currencyDkk => 'Corona danese (DKK)';

  @override
  String get currencyRon => 'Leu rumeno (RON)';

  @override
  String get currencyUah => 'Grivnia ucraina (₴)';

  @override
  String get currencyTry => 'Lira turca (₺)';

  @override
  String get currencyAed => 'Dirham degli EAU (AED)';

  @override
  String get currencySar => 'Riyal saudita (SAR)';

  @override
  String get currencyIls => 'Nuovo shekel israeliano (₪)';

  @override
  String get currencyZar => 'Rand sudafricano (ZAR)';

  @override
  String get currencyEgp => 'Sterlina egiziana (EGP)';

  @override
  String get currencyNgn => 'Naira nigeriana (NGN)';

  @override
  String get primaryBikeTitle => 'Bici principale';

  @override
  String get primaryBikeLabel => 'Seleziona bici principale';

  @override
  String get primaryBikeNone => 'Nessuna bici principale';

  @override
  String get primaryBikeEmpty =>
      'Aggiungi una bici per scegliere quella principale.';

  @override
  String get languageEnglish => 'Inglese';

  @override
  String get languageUkrainian => 'Ucraino';

  @override
  String get languageSpanish => 'Spagnolo';

  @override
  String get languageFrench => 'Francese';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageChinese => 'Cinese (semplificato)';

  @override
  String get biometricToggleTitle => 'Sblocco FaceID/TouchID';

  @override
  String get biometricToggleSubtitle => 'Richiedi biometria all’avvio';

  @override
  String get subscriptionTitle => 'Abbonamento';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => 'Gratuito';

  @override
  String get upgradeToPro => 'Passa a Pro';

  @override
  String get cancelPro => 'Annulla Pro';

  @override
  String get proRequiredMessage => 'Disponibile con PROS.TO Pro.';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava connesso';

  @override
  String get stravaDisconnected => 'Strava non connesso';

  @override
  String get stravaLocked => 'La sincronizzazione Strava è solo Pro';

  @override
  String get stravaConnectRequired => 'Connetti Strava per sincronizzare.';

  @override
  String get stravaSessionExpired => 'Sessione Strava scaduta. Riconnetti.';

  @override
  String get stravaSyncFailed =>
      'Sincronizzazione Strava non riuscita. Riprova.';

  @override
  String get stravaAuthFailed => 'Impossibile aprire Strava. Riprova.';

  @override
  String get stravaImporting => 'Importazione bici Strava...';

  @override
  String get stravaImportBikes => 'Importa bici da Strava';

  @override
  String get stravaImportFailed => 'Importazione Strava non riuscita. Riprova.';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return 'Importate $added, collegate $linked, ignorate $skipped.';
  }

  @override
  String get connectStrava => 'Connetti Strava';

  @override
  String get disconnectStrava => 'Disconnetti Strava';

  @override
  String get accountTitle => 'Account';

  @override
  String get phoneAuthStub => 'L’accesso telefonico arriverà presto.';

  @override
  String get openAuth => 'Apri accesso';

  @override
  String get aboutTitle => 'Informazioni';

  @override
  String versionLabel(Object version) {
    return 'Versione $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle =>
      'Sblocca funzioni premium di manutenzione e sincronizzazione.';

  @override
  String get proBenefitStrava => 'Sincronizzazione Strava';

  @override
  String get proBenefitUnlimited => 'Bici e componenti illimitati';

  @override
  String get proBenefitAlerts => 'Avvisi di manutenzione intelligenti';

  @override
  String get proPrice => '\$5 / mese';

  @override
  String get proPriceNote => 'Annulla in qualsiasi momento';

  @override
  String get startPro => 'Avvia Pro';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get phoneAuthTitle => 'Registrazione telefono';

  @override
  String get phoneAuthSubtitle => 'Accedi con il tuo numero di telefono (demo)';

  @override
  String get phoneNumberLabel => 'Numero di telefono';

  @override
  String get otpLabel => 'Codice';

  @override
  String get continueLabel => 'Continua';

  @override
  String get unlockTitle => 'Sblocca PROS.TO';

  @override
  String get unlockSubtitle => 'Usa la biometria per continuare';

  @override
  String get unlockAction => 'Sblocca';

  @override
  String get unlockReason => 'Autenticati per sbloccare PROS.TO';

  @override
  String get unlockDisableBiometrics => 'Disattiva biometria';
}
