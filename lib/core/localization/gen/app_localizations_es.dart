// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => 'Seguimiento de componentes y equipo de bicicleta';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => 'Controla tu bici. Conoce tu equipo.';

  @override
  String get aboutDescription =>
      'PROS.TO es una app premium de ciclismo pensada para ciclistas que cuidan su equipamiento.\nRegistra el kilometraje y el desgaste de cada componente, guarda el historial de reemplazos y entiende el coste real de tu configuración.\nDiseñada con una interfaz oscura y minimalista y acentos metálicos cálidos para claridad y enfoque.\n\nCaracterísticas clave:\n• Garaje de bicicletas con fotos y valor\n• Seguimiento de kilometraje y desgaste de componentes\n• Historial de reemplazos y análisis de costes\n• Inventario de equipamiento (cascos, zapatillas, kits y más)\n• Funcionamiento offline\n• Bloqueo con Face ID / Touch ID\n• Soporte de idiomas: inglés, ucraniano, español, francés, italiano y chino simplificado\n\nPROS.TO Pro:\n• Sincronización con Strava (actualizaciones automáticas de kilometraje)\n• Bicicletas y componentes ilimitados';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get homeTab => 'Inicio';

  @override
  String get garageTitle => 'Garaje';

  @override
  String get garageTab => 'Garaje';

  @override
  String get wardrobeTitle => 'Equipamiento';

  @override
  String get wardrobeTab => 'Equipo';

  @override
  String get insightsTitle => 'Análisis';

  @override
  String get insightsTab => 'Análisis';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsTab => 'Ajustes';

  @override
  String get lastSyncTitle => 'Última sincronización';

  @override
  String get lastSyncNever => 'Nunca sincronizado';

  @override
  String get addReplacement => 'Añadir reemplazo';

  @override
  String get syncStrava => 'Sincronizar Strava';

  @override
  String get syncingStrava => 'Sincronizando...';

  @override
  String get fullSyncStrava => 'Sincronización completa';

  @override
  String get fullSyncConfirmTitle => 'Sincronización completa de Strava';

  @override
  String get fullSyncConfirmBody =>
      'Esto importará todas las bicicletas de Strava y sincronizará su kilometraje total.';

  @override
  String get fullSyncConfirmAction => 'Sincronizar todo';

  @override
  String get fullSyncCancelAction => 'Cancelar';

  @override
  String get connectedStatus => 'Conectado';

  @override
  String get disconnectedStatus => 'No conectado';

  @override
  String get proOnlyStatus => 'Solo Pro';

  @override
  String get adjustBikeKm => 'Ajustar kilometraje';

  @override
  String currentTotalKmLabel(Object km) {
    return 'Total actual: $km km';
  }

  @override
  String get addKmLabel => 'Añadir km';

  @override
  String get setTotalKmLabel => 'Establecer km total';

  @override
  String get adjustComponentKm => 'Ajustar kilometraje del componente';

  @override
  String get componentKmLabel => 'Km del componente desde la instalación';

  @override
  String get yourBikes => 'Tus bicicletas';

  @override
  String get emptyGarageTitle => 'Aún no hay bicicletas';

  @override
  String get emptyGarageSubtitle =>
      'Añade tu primera bicicleta para empezar a trackear componentes.';

  @override
  String get addBike => 'Añadir bicicleta';

  @override
  String totalKmLabel(Object km) {
    return '$km km en total';
  }

  @override
  String get noComponentsYet => 'Aún no hay componentes';

  @override
  String get alertsTitle => 'Alertas de mantenimiento';

  @override
  String get alertsEmpty => 'Aún no hay componentes que requieran atención.';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return 'Alerta principal: $brand $model • $wearPercent%';
  }

  @override
  String get statusOk => 'OK';

  @override
  String get statusWatch => 'Vigilar';

  @override
  String get statusReplace => 'Reemplazar pronto';

  @override
  String get statusReplaceNow => 'Reemplazar ahora';

  @override
  String get alertTitleWatch => 'Vigilancia de mantenimiento';

  @override
  String get alertTitleReplace => 'Reemplazo necesario';

  @override
  String alertBodyWatch(Object component, Object bike, Object wear) {
    return '$component en $bike tiene $wear% de desgaste.';
  }

  @override
  String alertBodyReplace(Object component, Object bike, Object wear) {
    return '$component en $bike tiene $wear% de desgaste. Reemplaza pronto.';
  }

  @override
  String alertBodyReplaceNow(Object component, Object bike, Object wear) {
    return '$component en $bike tiene $wear% de desgaste. Reemplaza ahora.';
  }

  @override
  String get selectBike => 'Seleccionar bicicleta';

  @override
  String get selectComponent => 'Seleccionar componente';

  @override
  String syncSuccess(Object added, Object summary) {
    return 'Importadas $added actividades • $summary';
  }

  @override
  String get bikeDetailTitle => 'Detalle de bicicleta';

  @override
  String get bikeNotFound => 'Bicicleta no encontrada';

  @override
  String get componentsTitle => 'Componentes';

  @override
  String get addComponent => 'Añadir componente';

  @override
  String get categoryDrivetrain => 'Transmisión';

  @override
  String get categoryWheelsTires => 'Ruedas y neumáticos';

  @override
  String get categoryBrakes => 'Frenos';

  @override
  String get categoryCockpit => 'Cockpit';

  @override
  String get categoryOther => 'Otros';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '$km km desde la instalación • vida útil $expected km';
  }

  @override
  String purchasePriceLabel(Object price) {
    return 'Precio de compra: $price';
  }

  @override
  String get componentType => 'Tipo de componente';

  @override
  String get componentTypeChain => 'Cadena';

  @override
  String get componentTypeCassette => 'Cassette';

  @override
  String get componentTypeChainring => 'Plato';

  @override
  String get componentTypePowerMeter => 'Potenciómetro';

  @override
  String get componentTypeShifters => 'Manetas de cambio';

  @override
  String get componentTypeRearDerailleur => 'Desviador trasero';

  @override
  String get componentTypeFrontDerailleur => 'Desviador delantero';

  @override
  String get componentTypeWheels => 'Ruedas';

  @override
  String get componentTypeTires => 'Neumáticos';

  @override
  String get componentTypeBrakes => 'Frenos';

  @override
  String get componentTypeCockpit => 'Manillar';

  @override
  String get componentTypeStem => 'Potencia';

  @override
  String get componentTypeBarTape => 'Cinta de manillar';

  @override
  String get componentTypePedals => 'Pedales';

  @override
  String get componentTypeSaddle => 'Sillín';

  @override
  String get componentTypeOther => 'Otro';

  @override
  String get brandLabel => 'Marca';

  @override
  String get modelLabel => 'Modelo';

  @override
  String get componentNameLabel => 'Nombre del componente';

  @override
  String get componentDetailsOptionalLabel => 'Detalles (opcional)';

  @override
  String get expectedLifeLabel => 'Vida útil esperada (km)';

  @override
  String get priceOptionalLabel => 'Precio (opcional)';

  @override
  String get saveLabel => 'Guardar';

  @override
  String installedAtKm(Object km) {
    return 'Instalado a $km km';
  }

  @override
  String get editBike => 'Editar bicicleta';

  @override
  String get bikeNameLabel => 'Nombre de la bicicleta';

  @override
  String get requiredField => 'Requerido';

  @override
  String get purchasePriceOptional => 'Precio de compra (opcional)';

  @override
  String get deleteBike => 'Eliminar bicicleta';

  @override
  String get bikePhotoLabel => 'Foto de la bicicleta';

  @override
  String get pickPhoto => 'Toca para elegir una foto';

  @override
  String get photoPickerUnavailable =>
      'El selector de fotos no está disponible en esta plataforma.';

  @override
  String get componentDetailTitle => 'Detalle del componente';

  @override
  String get componentNotFound => 'Componente no encontrado';

  @override
  String get replaceComponent => 'Reemplazar componente';

  @override
  String get replacementHistory => 'Historial de reemplazos';

  @override
  String get noHistory => 'Aún no hay historial de reemplazos';

  @override
  String removedAtKm(Object km) {
    return 'Retirado a $km km';
  }

  @override
  String get removalKmLabel => 'Odómetro al retirar';

  @override
  String currentBikeKmLabel(Object km) {
    return 'Km actuales de la bici: $km';
  }

  @override
  String get newComponentTitle => 'Nuevo componente';

  @override
  String get totalGearValue => 'Valor total del equipamiento';

  @override
  String itemsCount(Object count) {
    return '$count artículos';
  }

  @override
  String get categoryHelmets => 'Cascos';

  @override
  String get categoryGlasses => 'Gafas';

  @override
  String get categoryJerseys => 'Maillots';

  @override
  String get categoryBibs => 'Culottes';

  @override
  String get categoryShoes => 'Zapatillas';

  @override
  String get categoryGloves => 'Guantes';

  @override
  String get categoryJackets => 'Chaquetas';

  @override
  String get categoryAccessories => 'Accesorios';

  @override
  String get emptyWardrobeCategory => 'Aún no hay artículos';

  @override
  String itemQuantity(Object quantity) {
    return 'Cant. $quantity';
  }

  @override
  String get addItem => 'Añadir artículo';

  @override
  String get editItem => 'Editar artículo';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get notesLabel => 'Notas';

  @override
  String get deleteItem => 'Eliminar artículo';

  @override
  String get totalBikeValue => 'Valor total de bicicletas';

  @override
  String totalKmAllBikes(Object km) {
    return 'Distancia total: $km km';
  }

  @override
  String totalGearValueLabel(Object value) {
    return 'Valor total del equipamiento: $value';
  }

  @override
  String get perBikeBreakdown => 'Desglose por bicicleta';

  @override
  String bikeValueLabel(Object value) {
    return 'Valor de la bicicleta: $value';
  }

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageProOnlyHint =>
      'Idiomas adicionales disponibles con PROS.TO Pro.';

  @override
  String get currencyTitle => 'Moneda';

  @override
  String get currencyProOnlyHint => 'Disponible con PROS.TO Pro.';

  @override
  String get currencyUsd => 'Dólar estadounidense (\$)';

  @override
  String get currencyEur => 'Euro (€)';

  @override
  String get currencyGbp => 'Libra esterlina (£)';

  @override
  String get currencyJpy => 'Yen japonés (¥)';

  @override
  String get currencyChf => 'Franco suizo (CHF)';

  @override
  String get currencyCny => 'Yuan chino (¥)';

  @override
  String get currencyHkd => 'Dólar de Hong Kong (HK\$)';

  @override
  String get currencySgd => 'Dólar de Singapur (S\$)';

  @override
  String get currencyKrw => 'Won surcoreano (₩)';

  @override
  String get currencyInr => 'Rupia india (₹)';

  @override
  String get currencyThb => 'Baht tailandés (฿)';

  @override
  String get currencyIdr => 'Rupia indonesia (Rp)';

  @override
  String get currencyMyr => 'Ringgit malayo (RM)';

  @override
  String get currencyPhp => 'Peso filipino (₱)';

  @override
  String get currencyCad => 'Dólar canadiense (CA\$)';

  @override
  String get currencyAud => 'Dólar australiano (A\$)';

  @override
  String get currencyNzd => 'Dólar neozelandés (NZ\$)';

  @override
  String get currencyMxn => 'Peso mexicano (MX\$)';

  @override
  String get currencyBrl => 'Real brasileño (R\$)';

  @override
  String get currencyArs => 'Peso argentino (AR\$)';

  @override
  String get currencyClp => 'Peso chileno (CLP\$)';

  @override
  String get currencyCop => 'Peso colombiano (COP\$)';

  @override
  String get currencyPln => 'Złoty polaco (zł)';

  @override
  String get currencyCzk => 'Corona checa (Kč)';

  @override
  String get currencyHuf => 'Forinto húngaro (Ft)';

  @override
  String get currencySek => 'Corona sueca (SEK)';

  @override
  String get currencyNok => 'Corona noruega (NOK)';

  @override
  String get currencyDkk => 'Corona danesa (DKK)';

  @override
  String get currencyRon => 'Leu rumano (RON)';

  @override
  String get currencyUah => 'Grivna ucraniana (₴)';

  @override
  String get currencyTry => 'Lira turca (₺)';

  @override
  String get currencyAed => 'Dirham de EAU (AED)';

  @override
  String get currencySar => 'Riyal saudí (SAR)';

  @override
  String get currencyIls => 'Nuevo séquel israelí (₪)';

  @override
  String get currencyZar => 'Rand sudafricano (ZAR)';

  @override
  String get currencyEgp => 'Libra egipcia (EGP)';

  @override
  String get currencyNgn => 'Naira nigeriana (NGN)';

  @override
  String get primaryBikeTitle => 'Bicicleta principal';

  @override
  String get primaryBikeLabel => 'Seleccionar bicicleta principal';

  @override
  String get primaryBikeNone => 'Sin bicicleta principal';

  @override
  String get primaryBikeEmpty =>
      'Añade una bicicleta para elegir una principal.';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageUkrainian => 'Ucraniano';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageItalian => 'Italiano';

  @override
  String get languageChinese => 'Chino (simplificado)';

  @override
  String get biometricToggleTitle => 'Desbloqueo FaceID/TouchID';

  @override
  String get biometricToggleSubtitle => 'Requerir biometría al iniciar';

  @override
  String get subscriptionTitle => 'Suscripción';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => 'Gratis';

  @override
  String get upgradeToPro => 'Mejorar a Pro';

  @override
  String get cancelPro => 'Cancelar Pro';

  @override
  String get proRequiredMessage => 'Disponible con PROS.TO Pro.';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava conectado';

  @override
  String get stravaDisconnected => 'Strava no conectado';

  @override
  String get stravaLocked => 'La sincronización con Strava es solo Pro';

  @override
  String get stravaConnectRequired => 'Conecta Strava para sincronizar.';

  @override
  String get stravaSessionExpired =>
      'La sesión de Strava expiró. Vuelve a conectar.';

  @override
  String get stravaSyncFailed =>
      'La sincronización con Strava falló. Inténtalo de nuevo.';

  @override
  String get stravaAuthFailed => 'No se pudo abrir Strava. Inténtalo de nuevo.';

  @override
  String get stravaImporting => 'Importando bicicletas de Strava...';

  @override
  String get stravaImportBikes => 'Importar bicicletas de Strava';

  @override
  String get stravaImportFailed =>
      'La importación de Strava falló. Inténtalo de nuevo.';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return 'Importadas $added, vinculadas $linked, omitidas $skipped.';
  }

  @override
  String get connectStrava => 'Conectar Strava';

  @override
  String get disconnectStrava => 'Desconectar Strava';

  @override
  String get accountTitle => 'Cuenta';

  @override
  String get phoneAuthStub =>
      'El inicio de sesión por teléfono llegará pronto.';

  @override
  String get openAuth => 'Abrir inicio de sesión';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String versionLabel(Object version) {
    return 'Versión $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle =>
      'Desbloquea funciones premium de mantenimiento y sincronización.';

  @override
  String get proBenefitStrava => 'Sincronización con Strava';

  @override
  String get proBenefitUnlimited => 'Bicicletas y componentes ilimitados';

  @override
  String get proBenefitAlerts => 'Alertas de mantenimiento inteligentes';

  @override
  String get proPrice => '\$5 / mes';

  @override
  String get proPriceNote => 'Cancela cuando quieras';

  @override
  String get startPro => 'Empezar Pro';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get phoneAuthTitle => 'Registro por teléfono';

  @override
  String get phoneAuthSubtitle =>
      'Inicia sesión con tu número de teléfono (demo)';

  @override
  String get phoneNumberLabel => 'Número de teléfono';

  @override
  String get otpLabel => 'Código';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get unlockTitle => 'Desbloquear PROS.TO';

  @override
  String get unlockSubtitle => 'Usa biometría para continuar';

  @override
  String get unlockAction => 'Desbloquear';

  @override
  String get unlockReason => 'Autentícate para desbloquear PROS.TO';

  @override
  String get unlockDisableBiometrics => 'Desactivar biometría';
}
