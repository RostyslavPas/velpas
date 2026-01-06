// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'VelPas';

  @override
  String get tagline => 'Катай. Трекни. Міняй вчасно.';

  @override
  String get aboutDescription =>
      'VelPas — це застосунок для велоспільноти: облік пробігу компонентів, історії замін і гардероба. Працює офлайн та допомагає вчасно обслуговувати байк і спорядження.';

  @override
  String get homeTitle => 'Головна';

  @override
  String get garageTitle => 'Гараж';

  @override
  String get wardrobeTitle => 'Гардероб';

  @override
  String get insightsTitle => 'Аналітика';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get settingsTab => 'Налашт.';

  @override
  String get lastSyncTitle => 'Остання синхронізація';

  @override
  String get lastSyncNever => 'Ще не синхронізовано';

  @override
  String get addReplacement => 'Додати заміну';

  @override
  String get syncStrava => 'Синхронізувати Strava';

  @override
  String get yourBikes => 'Ваші велосипеди';

  @override
  String get emptyGarageTitle => 'Ще немає велосипедів';

  @override
  String get emptyGarageSubtitle =>
      'Додайте перший байк, щоб почати трекінг компонентів.';

  @override
  String get addBike => 'Додати велосипед';

  @override
  String totalKmLabel(Object km) {
    return '$km км загалом';
  }

  @override
  String get noComponentsYet => 'Компонентів ще немає';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return 'Топ-алерт: $brand $model • $wearPercent%';
  }

  @override
  String get statusOk => 'ОК';

  @override
  String get statusWatch => 'Увага';

  @override
  String get statusReplace => 'Скоро заміна';

  @override
  String get statusReplaceNow => 'Потрібна заміна';

  @override
  String get selectBike => 'Оберіть велосипед';

  @override
  String get selectComponent => 'Оберіть компонент';

  @override
  String syncSuccess(Object added, Object summary) {
    return 'Імпортовано $added поїздок • $summary';
  }

  @override
  String get bikeDetailTitle => 'Деталі велосипеда';

  @override
  String get bikeNotFound => 'Велосипед не знайдено';

  @override
  String get componentsTitle => 'Компоненти';

  @override
  String get addComponent => 'Додати компонент';

  @override
  String get categoryDrivetrain => 'Трансмісія';

  @override
  String get categoryWheelsTires => 'Колеса й шини';

  @override
  String get categoryBrakes => 'Гальма';

  @override
  String get categoryCockpit => 'Кокпіт';

  @override
  String get categoryOther => 'Інше';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '$km км після установки • ресурс $expected км';
  }

  @override
  String purchasePriceLabel(Object price) {
    return 'Ціна покупки: $price';
  }

  @override
  String get componentType => 'Тип компонента';

  @override
  String get componentTypeChain => 'Ланцюг';

  @override
  String get componentTypeCassette => 'Касета';

  @override
  String get componentTypeChainring => 'Зірка';

  @override
  String get componentTypePowerMeter => 'Паверметр';

  @override
  String get componentTypeShifters => 'Манетки';

  @override
  String get componentTypeRearDerailleur => 'Задній перемикач';

  @override
  String get componentTypeFrontDerailleur => 'Передній перемикач';

  @override
  String get componentTypeWheels => 'Колеса';

  @override
  String get componentTypeTires => 'Покришки';

  @override
  String get componentTypeBrakes => 'Гальма';

  @override
  String get componentTypeCockpit => 'Кокпіт';

  @override
  String get componentTypeOther => 'Інше';

  @override
  String get brandLabel => 'Бренд';

  @override
  String get modelLabel => 'Модель';

  @override
  String get expectedLifeLabel => 'Очікуваний ресурс (км)';

  @override
  String get priceOptionalLabel => 'Ціна (необов\'язково)';

  @override
  String get saveLabel => 'Зберегти';

  @override
  String installedAtKm(Object km) {
    return 'Встановлено на $km км';
  }

  @override
  String get editBike => 'Редагувати велосипед';

  @override
  String get bikeNameLabel => 'Назва велосипеда';

  @override
  String get requiredField => 'Обов\'язкове';

  @override
  String get purchasePriceOptional => 'Ціна покупки (необов\'язково)';

  @override
  String get deleteBike => 'Видалити велосипед';

  @override
  String get bikePhotoLabel => 'Фото велосипеда';

  @override
  String get pickPhoto => 'Торкніться, щоб додати фото';

  @override
  String get photoPickerUnavailable =>
      'Вибір фото недоступний на цій платформі.';

  @override
  String get componentDetailTitle => 'Деталі компонента';

  @override
  String get componentNotFound => 'Компонент не знайдено';

  @override
  String get replaceComponent => 'Замінити компонент';

  @override
  String get replacementHistory => 'Історія замін';

  @override
  String get noHistory => 'Історії замін ще немає';

  @override
  String removedAtKm(Object km) {
    return 'Знято на $km км';
  }

  @override
  String get removalKmLabel => 'Пробіг при знятті';

  @override
  String currentBikeKmLabel(Object km) {
    return 'Поточний пробіг: $km';
  }

  @override
  String get newComponentTitle => 'Новий компонент';

  @override
  String get totalGearValue => 'Загальна вартість спорядження';

  @override
  String itemsCount(Object count) {
    return '$count речей';
  }

  @override
  String get categoryHelmets => 'Шоломи';

  @override
  String get categoryGlasses => 'Окуляри';

  @override
  String get categoryJerseys => 'Джерсі';

  @override
  String get categoryBibs => 'Велотруси';

  @override
  String get categoryShoes => 'Взуття';

  @override
  String get categoryGloves => 'Рукавички';

  @override
  String get categoryJackets => 'Куртки';

  @override
  String get categoryAccessories => 'Аксесуари';

  @override
  String get emptyWardrobeCategory => 'Ще немає речей';

  @override
  String itemQuantity(Object quantity) {
    return 'К-ть $quantity';
  }

  @override
  String get addItem => 'Додати річ';

  @override
  String get editItem => 'Редагувати річ';

  @override
  String get quantityLabel => 'Кількість';

  @override
  String get notesLabel => 'Нотатки';

  @override
  String get deleteItem => 'Видалити річ';

  @override
  String get totalBikeValue => 'Загальна вартість велосипедів';

  @override
  String totalKmAllBikes(Object km) {
    return 'Загальний пробіг: $km км';
  }

  @override
  String totalGearValueLabel(Object value) {
    return 'Вартість спорядження: $value';
  }

  @override
  String get perBikeBreakdown => 'По кожному байку';

  @override
  String bikeValueLabel(Object value) {
    return 'Вартість байка: $value';
  }

  @override
  String get languageTitle => 'Мова';

  @override
  String get primaryBikeTitle => 'Основний велосипед';

  @override
  String get primaryBikeLabel => 'Виберіть основний велосипед';

  @override
  String get primaryBikeNone => 'Без основного велосипеда';

  @override
  String get primaryBikeEmpty => 'Додайте велосипед, щоб вибрати основний.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUkrainian => 'Українська';

  @override
  String get biometricToggleTitle => 'Розблокування FaceID/TouchID';

  @override
  String get biometricToggleSubtitle => 'Вимагати біометрію при запуску';

  @override
  String get subscriptionTitle => 'Підписка';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => 'Free';

  @override
  String get upgradeToPro => 'Оновити до Pro';

  @override
  String get cancelPro => 'Скасувати Pro';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava підключено';

  @override
  String get stravaDisconnected => 'Strava не підключено';

  @override
  String get stravaLocked => 'Синхронізація Strava лише для Pro';

  @override
  String get stravaConnectRequired => 'Підключіть Strava для синхронізації.';

  @override
  String get stravaSessionExpired =>
      'Сесія Strava завершилась. Підключіть знову.';

  @override
  String get stravaSyncFailed =>
      'Синхронізація Strava не вдалася. Спробуйте ще раз.';

  @override
  String get stravaAuthFailed =>
      'Не вдалося відкрити Strava. Спробуйте ще раз.';

  @override
  String get stravaImporting => 'Імпорт велосипедів зі Strava...';

  @override
  String get stravaImportBikes => 'Імпортувати велосипеди зі Strava';

  @override
  String get stravaImportFailed => 'Імпорт Strava не вдався. Спробуйте ще раз.';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return 'Імпортовано $added, повʼязано $linked, пропущено $skipped.';
  }

  @override
  String get connectStrava => 'Підключити Strava';

  @override
  String get disconnectStrava => 'Відключити Strava';

  @override
  String get accountTitle => 'Акаунт';

  @override
  String get phoneAuthStub => 'Вхід за номером телефону скоро.';

  @override
  String get openAuth => 'Відкрити вхід';

  @override
  String get aboutTitle => 'Про застосунок';

  @override
  String versionLabel(Object version) {
    return 'Версія $version';
  }

  @override
  String get paywallTitle => 'VelPas Pro';

  @override
  String get proTitle => 'VelPas Pro';

  @override
  String get proSubtitle => 'Відкрийте преміум-функції та синхронізацію.';

  @override
  String get proBenefitStrava => 'Синхронізація Strava';

  @override
  String get proBenefitUnlimited => 'Необмежені велосипеди й компоненти';

  @override
  String get proBenefitAlerts => 'Розумні сповіщення (скоро)';

  @override
  String get proPrice => '\$5 / місяць';

  @override
  String get proPriceNote => 'Скасування будь-коли';

  @override
  String get startPro => 'Почати Pro';

  @override
  String get restorePurchases => 'Відновити покупки';

  @override
  String get phoneAuthTitle => 'Реєстрація за телефоном';

  @override
  String get phoneAuthSubtitle => 'Вхід за номером телефону (заглушка)';

  @override
  String get phoneNumberLabel => 'Номер телефону';

  @override
  String get otpLabel => 'Код';

  @override
  String get continueLabel => 'Продовжити';

  @override
  String get unlockTitle => 'Розблокувати VelPas';

  @override
  String get unlockSubtitle => 'Використайте біометрію для входу';

  @override
  String get unlockAction => 'Розблокувати';
}
