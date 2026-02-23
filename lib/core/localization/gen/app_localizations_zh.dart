// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => '自行车组件与装备追踪';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => '记录你的单车。了解你的装备。';

  @override
  String get aboutDescription =>
      'PROS.TO 是一款为重视装备的骑行者打造的高端应用。\n追踪每个组件的里程与磨损，记录更换历史，了解你的整车真实成本。\n采用深色极简界面与暖金属点缀，带来清晰专注的体验。\n\n核心功能：\n• 带照片和价值的车库\n• 组件里程与磨损追踪\n• 更换历史与成本分析\n• 装备清单（头盔、骑行鞋、车服等）\n• 离线优先\n• Face ID / Touch ID 应用锁\n• 支持英语、乌克兰语、西班牙语、法语、意大利语和简体中文\n\nPROS.TO Pro：\n• Strava 同步（自动更新里程）\n• 无限自行车与组件';

  @override
  String get homeTitle => '主页';

  @override
  String get homeTab => '首页';

  @override
  String get garageTitle => '车库';

  @override
  String get garageTab => '车库';

  @override
  String get wardrobeTitle => '装备';

  @override
  String get wardrobeTab => '装备';

  @override
  String get insightsTitle => '分析';

  @override
  String get insightsTab => '分析';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsTab => '设置';

  @override
  String get lastSyncTitle => '上次同步';

  @override
  String get lastSyncNever => '从未同步';

  @override
  String get addReplacement => '添加更换';

  @override
  String get syncStrava => '同步 Strava';

  @override
  String get syncingStrava => '同步中...';

  @override
  String get fullSyncStrava => '完全同步';

  @override
  String get fullSyncConfirmTitle => 'Strava 完全同步';

  @override
  String get fullSyncConfirmBody => '此操作将导入所有 Strava 自行车并同步其总里程。';

  @override
  String get fullSyncConfirmAction => '同步全部';

  @override
  String get fullSyncCancelAction => '取消';

  @override
  String get connectedStatus => '已连接';

  @override
  String get disconnectedStatus => '未连接';

  @override
  String get proOnlyStatus => '仅 Pro';

  @override
  String get adjustBikeKm => '调整里程';

  @override
  String currentTotalKmLabel(Object km) {
    return '当前总里程：$km 公里';
  }

  @override
  String get addKmLabel => '增加公里数';

  @override
  String get setTotalKmLabel => '设置总公里数';

  @override
  String get adjustComponentKm => '调整组件里程';

  @override
  String get componentKmLabel => '组件安装后公里数';

  @override
  String get yourBikes => '你的自行车';

  @override
  String get emptyGarageTitle => '暂无自行车';

  @override
  String get emptyGarageSubtitle => '添加第一辆自行车开始追踪组件。';

  @override
  String get addBike => '添加自行车';

  @override
  String totalKmLabel(Object km) {
    return '总计 $km 公里';
  }

  @override
  String get noComponentsYet => '暂无组件';

  @override
  String get alertsTitle => '维护提醒';

  @override
  String get alertsEmpty => '暂无需要关注的组件。';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return '最高提醒：$brand $model • $wearPercent%';
  }

  @override
  String get statusOk => '正常';

  @override
  String get statusWatch => '注意';

  @override
  String get statusReplace => '尽快更换';

  @override
  String get statusReplaceNow => '立即更换';

  @override
  String get alertTitleWatch => '维护提醒';

  @override
  String get alertTitleReplace => '需要更换';

  @override
  String alertBodyWatch(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%.';
  }

  @override
  String alertBodyReplace(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%。请尽快更换。';
  }

  @override
  String alertBodyReplaceNow(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%。请立即更换。';
  }

  @override
  String get selectBike => '选择自行车';

  @override
  String get selectComponent => '选择组件';

  @override
  String syncSuccess(Object added, Object summary) {
    return '已导入 $added 条活动 • $summary';
  }

  @override
  String get bikeDetailTitle => '自行车详情';

  @override
  String get bikeNotFound => '未找到自行车';

  @override
  String get componentsTitle => '组件';

  @override
  String get addComponent => '添加组件';

  @override
  String get categoryDrivetrain => '传动系统';

  @override
  String get categoryWheelsTires => '轮组与轮胎';

  @override
  String get categoryBrakes => '刹车';

  @override
  String get categoryCockpit => '车把区';

  @override
  String get categoryOther => '其他';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '安装后 $km 公里 • 寿命 $expected 公里';
  }

  @override
  String purchasePriceLabel(Object price) {
    return '购买价格：$price';
  }

  @override
  String get componentType => '组件类型';

  @override
  String get componentTypeChain => '链条';

  @override
  String get componentTypeCassette => '飞轮';

  @override
  String get componentTypeChainring => '牙盘';

  @override
  String get componentTypePowerMeter => '功率计';

  @override
  String get componentTypeShifters => '变速手柄';

  @override
  String get componentTypeRearDerailleur => '后变速器';

  @override
  String get componentTypeFrontDerailleur => '前变速器';

  @override
  String get componentTypeWheels => '轮组';

  @override
  String get componentTypeTires => '轮胎';

  @override
  String get componentTypeBrakes => '刹车';

  @override
  String get componentTypeCockpit => '车把';

  @override
  String get componentTypeStem => '把立';

  @override
  String get componentTypeBarTape => '车把带';

  @override
  String get componentTypePedals => '踏板';

  @override
  String get componentTypeSaddle => '坐垫';

  @override
  String get componentTypeOther => '其他';

  @override
  String get brandLabel => '品牌';

  @override
  String get modelLabel => '型号';

  @override
  String get componentNameLabel => '组件名称';

  @override
  String get componentDetailsOptionalLabel => '详细信息（可选）';

  @override
  String get expectedLifeLabel => '预计寿命（公里）';

  @override
  String get priceOptionalLabel => '价格（可选）';

  @override
  String get saveLabel => '保存';

  @override
  String installedAtKm(Object km) {
    return '安装于 $km 公里';
  }

  @override
  String get editBike => '编辑自行车';

  @override
  String get bikeNameLabel => '自行车名称';

  @override
  String get requiredField => '必填';

  @override
  String get purchasePriceOptional => '购买价格（可选）';

  @override
  String get deleteBike => '删除自行车';

  @override
  String get bikePhotoLabel => '自行车照片';

  @override
  String get pickPhoto => '点击选择照片';

  @override
  String get photoPickerUnavailable => '此平台不支持照片选择。';

  @override
  String get componentDetailTitle => '组件详情';

  @override
  String get componentNotFound => '未找到组件';

  @override
  String get replaceComponent => '更换组件';

  @override
  String get replacementHistory => '更换历史';

  @override
  String get noHistory => '暂无更换历史';

  @override
  String removedAtKm(Object km) {
    return '在 $km 公里移除';
  }

  @override
  String get removalKmLabel => '拆卸时里程';

  @override
  String currentBikeKmLabel(Object km) {
    return '当前自行车里程：$km';
  }

  @override
  String get newComponentTitle => '新组件';

  @override
  String get totalGearValue => '装备总价值';

  @override
  String itemsCount(Object count) {
    return '$count 件';
  }

  @override
  String get categoryHelmets => '头盔';

  @override
  String get categoryGlasses => '眼镜';

  @override
  String get categoryJerseys => '骑行服';

  @override
  String get categoryBibs => '背带短裤';

  @override
  String get categoryShoes => '骑行鞋';

  @override
  String get categoryGloves => '手套';

  @override
  String get categoryJackets => '夹克';

  @override
  String get categoryAccessories => '配件';

  @override
  String get emptyWardrobeCategory => '暂无物品';

  @override
  String itemQuantity(Object quantity) {
    return '数量 $quantity';
  }

  @override
  String get addItem => '添加物品';

  @override
  String get editItem => '编辑物品';

  @override
  String get quantityLabel => '数量';

  @override
  String get notesLabel => '备注';

  @override
  String get deleteItem => '删除物品';

  @override
  String get totalBikeValue => '自行车总价值';

  @override
  String totalKmAllBikes(Object km) {
    return '总里程：$km 公里';
  }

  @override
  String totalGearValueLabel(Object value) {
    return '装备总价值：$value';
  }

  @override
  String get perBikeBreakdown => '按自行车统计';

  @override
  String bikeValueLabel(Object value) {
    return '自行车价值：$value';
  }

  @override
  String get languageTitle => '语言';

  @override
  String get languageProOnlyHint => '更多语言仅在 PROS.TO Pro 中可用。';

  @override
  String get currencyTitle => '货币';

  @override
  String get currencyProOnlyHint => '仅 PROS.TO Pro 可用。';

  @override
  String get currencyUsd => '美元 (\$)';

  @override
  String get currencyEur => '欧元 (€)';

  @override
  String get currencyGbp => '英镑 (£)';

  @override
  String get currencyJpy => '日元 (¥)';

  @override
  String get currencyChf => '瑞士法郎 (CHF)';

  @override
  String get currencyCny => '人民币 (¥)';

  @override
  String get currencyHkd => '港币 (HK\$)';

  @override
  String get currencySgd => '新加坡元 (S\$)';

  @override
  String get currencyKrw => '韩元 (₩)';

  @override
  String get currencyInr => '印度卢比 (₹)';

  @override
  String get currencyThb => '泰铢 (฿)';

  @override
  String get currencyIdr => '印尼盾 (Rp)';

  @override
  String get currencyMyr => '马来西亚林吉特 (RM)';

  @override
  String get currencyPhp => '菲律宾比索 (₱)';

  @override
  String get currencyCad => '加元 (CA\$)';

  @override
  String get currencyAud => '澳元 (A\$)';

  @override
  String get currencyNzd => '新西兰元 (NZ\$)';

  @override
  String get currencyMxn => '墨西哥比索 (MX\$)';

  @override
  String get currencyBrl => '巴西雷亚尔 (R\$)';

  @override
  String get currencyArs => '阿根廷比索 (AR\$)';

  @override
  String get currencyClp => '智利比索 (CLP\$)';

  @override
  String get currencyCop => '哥伦比亚比索 (COP\$)';

  @override
  String get currencyPln => '波兰兹罗提 (zł)';

  @override
  String get currencyCzk => '捷克克朗 (Kč)';

  @override
  String get currencyHuf => '匈牙利福林 (Ft)';

  @override
  String get currencySek => '瑞典克朗 (SEK)';

  @override
  String get currencyNok => '挪威克朗 (NOK)';

  @override
  String get currencyDkk => '丹麦克朗 (DKK)';

  @override
  String get currencyRon => '罗马尼亚列伊 (RON)';

  @override
  String get currencyUah => '乌克兰格里夫纳 (₴)';

  @override
  String get currencyTry => '土耳其里拉 (₺)';

  @override
  String get currencyAed => '阿联酋迪拉姆 (AED)';

  @override
  String get currencySar => '沙特里亚尔 (SAR)';

  @override
  String get currencyIls => '以色列新谢克尔 (₪)';

  @override
  String get currencyZar => '南非兰特 (ZAR)';

  @override
  String get currencyEgp => '埃及镑 (EGP)';

  @override
  String get currencyNgn => '尼日利亚奈拉 (NGN)';

  @override
  String get primaryBikeTitle => '主力自行车';

  @override
  String get primaryBikeLabel => '选择主力自行车';

  @override
  String get primaryBikeNone => '未选择主力自行车';

  @override
  String get primaryBikeEmpty => '添加自行车以选择主力自行车。';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageUkrainian => '乌克兰语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageChinese => '简体中文';

  @override
  String get biometricToggleTitle => 'FaceID/TouchID 解锁';

  @override
  String get biometricToggleSubtitle => '启动时要求生物识别';

  @override
  String get subscriptionTitle => '订阅';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => '免费';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get cancelPro => '取消 Pro';

  @override
  String get proRequiredMessage => '仅 PROS.TO Pro 可用。';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava 已连接';

  @override
  String get stravaDisconnected => 'Strava 未连接';

  @override
  String get stravaLocked => 'Strava 同步仅 Pro 可用';

  @override
  String get stravaConnectRequired => '连接 Strava 以同步。';

  @override
  String get stravaSessionExpired => 'Strava 会话已过期，请重新连接。';

  @override
  String get stravaSyncFailed => 'Strava 同步失败，请重试。';

  @override
  String get stravaAuthFailed => '无法打开 Strava，请重试。';

  @override
  String get stravaImporting => '正在导入 Strava 自行车...';

  @override
  String get stravaImportBikes => '从 Strava 导入自行车';

  @override
  String get stravaImportFailed => 'Strava 导入失败，请重试。';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return '已导入 $added，已关联 $linked，已跳过 $skipped。';
  }

  @override
  String get connectStrava => '连接 Strava';

  @override
  String get disconnectStrava => '断开 Strava';

  @override
  String get accountTitle => '账户';

  @override
  String get phoneAuthStub => '手机号登录即将推出。';

  @override
  String get openAuth => '打开登录';

  @override
  String get aboutTitle => '关于';

  @override
  String versionLabel(Object version) {
    return '版本 $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle => '解锁高级维护与同步功能。';

  @override
  String get proBenefitStrava => 'Strava 同步';

  @override
  String get proBenefitUnlimited => '无限自行车与组件';

  @override
  String get proBenefitAlerts => '智能维护提醒';

  @override
  String get proPrice => '\$5 / 月';

  @override
  String get proPriceNote => '随时取消';

  @override
  String get startPro => '开始 Pro';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get phoneAuthTitle => '手机注册';

  @override
  String get phoneAuthSubtitle => '使用手机号登录（演示）';

  @override
  String get phoneNumberLabel => '手机号';

  @override
  String get otpLabel => '验证码';

  @override
  String get continueLabel => '继续';

  @override
  String get unlockTitle => '解锁 PROS.TO';

  @override
  String get unlockSubtitle => '使用生物识别继续';

  @override
  String get unlockAction => '解锁';

  @override
  String get unlockReason => '请验证以解锁 PROS.TO';

  @override
  String get unlockDisableBiometrics => '关闭生物识别';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appName => 'PROS.TO';

  @override
  String get appSubtitle => '自行车组件与装备追踪';

  @override
  String get brandSignature => 'by PASUE';

  @override
  String get tagline => '记录你的单车。了解你的装备。';

  @override
  String get aboutDescription =>
      'PROS.TO 是一款为重视装备的骑行者打造的高端应用。\n追踪每个组件的里程与磨损，记录更换历史，了解你的整车真实成本。\n采用深色极简界面与暖金属点缀，带来清晰专注的体验。\n\n核心功能：\n• 带照片和价值的车库\n• 组件里程与磨损追踪\n• 更换历史与成本分析\n• 装备清单（头盔、骑行鞋、车服等）\n• 离线优先\n• Face ID / Touch ID 应用锁\n• 支持英语、乌克兰语、西班牙语、法语、意大利语和简体中文\n\nPROS.TO Pro：\n• Strava 同步（自动更新里程）\n• 无限自行车与组件';

  @override
  String get homeTitle => '主页';

  @override
  String get homeTab => '首页';

  @override
  String get garageTitle => '车库';

  @override
  String get garageTab => '车库';

  @override
  String get wardrobeTitle => '装备';

  @override
  String get wardrobeTab => '装备';

  @override
  String get insightsTitle => '分析';

  @override
  String get insightsTab => '分析';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsTab => '设置';

  @override
  String get lastSyncTitle => '上次同步';

  @override
  String get lastSyncNever => '从未同步';

  @override
  String get addReplacement => '添加更换';

  @override
  String get syncStrava => '同步 Strava';

  @override
  String get syncingStrava => '同步中...';

  @override
  String get fullSyncStrava => '完全同步';

  @override
  String get fullSyncConfirmTitle => 'Strava 完全同步';

  @override
  String get fullSyncConfirmBody => '此操作将导入所有 Strava 自行车并同步其总里程。';

  @override
  String get fullSyncConfirmAction => '同步全部';

  @override
  String get fullSyncCancelAction => '取消';

  @override
  String get connectedStatus => '已连接';

  @override
  String get disconnectedStatus => '未连接';

  @override
  String get proOnlyStatus => '仅 Pro';

  @override
  String get adjustBikeKm => '调整里程';

  @override
  String currentTotalKmLabel(Object km) {
    return '当前总里程：$km 公里';
  }

  @override
  String get addKmLabel => '增加公里数';

  @override
  String get setTotalKmLabel => '设置总公里数';

  @override
  String get adjustComponentKm => '调整组件里程';

  @override
  String get componentKmLabel => '组件安装后公里数';

  @override
  String get yourBikes => '你的自行车';

  @override
  String get emptyGarageTitle => '暂无自行车';

  @override
  String get emptyGarageSubtitle => '添加第一辆自行车开始追踪组件。';

  @override
  String get addBike => '添加自行车';

  @override
  String totalKmLabel(Object km) {
    return '总计 $km 公里';
  }

  @override
  String get noComponentsYet => '暂无组件';

  @override
  String get alertsTitle => '维护提醒';

  @override
  String get alertsEmpty => '暂无需要关注的组件。';

  @override
  String topAlertLabel(Object brand, Object model, Object wearPercent) {
    return '最高提醒：$brand $model • $wearPercent%';
  }

  @override
  String get statusOk => '正常';

  @override
  String get statusWatch => '注意';

  @override
  String get statusReplace => '尽快更换';

  @override
  String get statusReplaceNow => '立即更换';

  @override
  String get alertTitleWatch => '维护提醒';

  @override
  String get alertTitleReplace => '需要更换';

  @override
  String alertBodyWatch(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%.';
  }

  @override
  String alertBodyReplace(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%。请尽快更换。';
  }

  @override
  String alertBodyReplaceNow(Object component, Object bike, Object wear) {
    return '$bike 上的 $component 已磨损 $wear%。请立即更换。';
  }

  @override
  String get selectBike => '选择自行车';

  @override
  String get selectComponent => '选择组件';

  @override
  String syncSuccess(Object added, Object summary) {
    return '已导入 $added 条活动 • $summary';
  }

  @override
  String get bikeDetailTitle => '自行车详情';

  @override
  String get bikeNotFound => '未找到自行车';

  @override
  String get componentsTitle => '组件';

  @override
  String get addComponent => '添加组件';

  @override
  String get categoryDrivetrain => '传动系统';

  @override
  String get categoryWheelsTires => '轮组与轮胎';

  @override
  String get categoryBrakes => '刹车';

  @override
  String get categoryCockpit => '车把区';

  @override
  String get categoryOther => '其他';

  @override
  String kmSinceInstall(Object km, Object expected) {
    return '安装后 $km 公里 • 寿命 $expected 公里';
  }

  @override
  String purchasePriceLabel(Object price) {
    return '购买价格：$price';
  }

  @override
  String get componentType => '组件类型';

  @override
  String get componentTypeChain => '链条';

  @override
  String get componentTypeCassette => '飞轮';

  @override
  String get componentTypeChainring => '牙盘';

  @override
  String get componentTypePowerMeter => '功率计';

  @override
  String get componentTypeShifters => '变速手柄';

  @override
  String get componentTypeRearDerailleur => '后变速器';

  @override
  String get componentTypeFrontDerailleur => '前变速器';

  @override
  String get componentTypeWheels => '轮组';

  @override
  String get componentTypeTires => '轮胎';

  @override
  String get componentTypeBrakes => '刹车';

  @override
  String get componentTypeCockpit => '车把';

  @override
  String get componentTypeStem => '把立';

  @override
  String get componentTypeBarTape => '车把带';

  @override
  String get componentTypePedals => '踏板';

  @override
  String get componentTypeSaddle => '坐垫';

  @override
  String get componentTypeOther => '其他';

  @override
  String get brandLabel => '品牌';

  @override
  String get modelLabel => '型号';

  @override
  String get componentNameLabel => '组件名称';

  @override
  String get componentDetailsOptionalLabel => '详细信息（可选）';

  @override
  String get expectedLifeLabel => '预计寿命（公里）';

  @override
  String get priceOptionalLabel => '价格（可选）';

  @override
  String get saveLabel => '保存';

  @override
  String installedAtKm(Object km) {
    return '安装于 $km 公里';
  }

  @override
  String get editBike => '编辑自行车';

  @override
  String get bikeNameLabel => '自行车名称';

  @override
  String get requiredField => '必填';

  @override
  String get purchasePriceOptional => '购买价格（可选）';

  @override
  String get deleteBike => '删除自行车';

  @override
  String get bikePhotoLabel => '自行车照片';

  @override
  String get pickPhoto => '点击选择照片';

  @override
  String get photoPickerUnavailable => '此平台不支持照片选择。';

  @override
  String get componentDetailTitle => '组件详情';

  @override
  String get componentNotFound => '未找到组件';

  @override
  String get replaceComponent => '更换组件';

  @override
  String get replacementHistory => '更换历史';

  @override
  String get noHistory => '暂无更换历史';

  @override
  String removedAtKm(Object km) {
    return '在 $km 公里移除';
  }

  @override
  String get removalKmLabel => '拆卸时里程';

  @override
  String currentBikeKmLabel(Object km) {
    return '当前自行车里程：$km';
  }

  @override
  String get newComponentTitle => '新组件';

  @override
  String get totalGearValue => '装备总价值';

  @override
  String itemsCount(Object count) {
    return '$count 件';
  }

  @override
  String get categoryHelmets => '头盔';

  @override
  String get categoryGlasses => '眼镜';

  @override
  String get categoryJerseys => '骑行服';

  @override
  String get categoryBibs => '背带短裤';

  @override
  String get categoryShoes => '骑行鞋';

  @override
  String get categoryGloves => '手套';

  @override
  String get categoryJackets => '夹克';

  @override
  String get categoryAccessories => '配件';

  @override
  String get emptyWardrobeCategory => '暂无物品';

  @override
  String itemQuantity(Object quantity) {
    return '数量 $quantity';
  }

  @override
  String get addItem => '添加物品';

  @override
  String get editItem => '编辑物品';

  @override
  String get quantityLabel => '数量';

  @override
  String get notesLabel => '备注';

  @override
  String get deleteItem => '删除物品';

  @override
  String get totalBikeValue => '自行车总价值';

  @override
  String totalKmAllBikes(Object km) {
    return '总里程：$km 公里';
  }

  @override
  String totalGearValueLabel(Object value) {
    return '装备总价值：$value';
  }

  @override
  String get perBikeBreakdown => '按自行车统计';

  @override
  String bikeValueLabel(Object value) {
    return '自行车价值：$value';
  }

  @override
  String get languageTitle => '语言';

  @override
  String get languageProOnlyHint => '更多语言仅在 PROS.TO Pro 中可用。';

  @override
  String get currencyTitle => '货币';

  @override
  String get currencyProOnlyHint => '仅 PROS.TO Pro 可用。';

  @override
  String get currencyUsd => '美元 (\$)';

  @override
  String get currencyEur => '欧元 (€)';

  @override
  String get currencyGbp => '英镑 (£)';

  @override
  String get currencyJpy => '日元 (¥)';

  @override
  String get currencyChf => '瑞士法郎 (CHF)';

  @override
  String get currencyCny => '人民币 (¥)';

  @override
  String get currencyHkd => '港币 (HK\$)';

  @override
  String get currencySgd => '新加坡元 (S\$)';

  @override
  String get currencyKrw => '韩元 (₩)';

  @override
  String get currencyInr => '印度卢比 (₹)';

  @override
  String get currencyThb => '泰铢 (฿)';

  @override
  String get currencyIdr => '印尼盾 (Rp)';

  @override
  String get currencyMyr => '马来西亚林吉特 (RM)';

  @override
  String get currencyPhp => '菲律宾比索 (₱)';

  @override
  String get currencyCad => '加元 (CA\$)';

  @override
  String get currencyAud => '澳元 (A\$)';

  @override
  String get currencyNzd => '新西兰元 (NZ\$)';

  @override
  String get currencyMxn => '墨西哥比索 (MX\$)';

  @override
  String get currencyBrl => '巴西雷亚尔 (R\$)';

  @override
  String get currencyArs => '阿根廷比索 (AR\$)';

  @override
  String get currencyClp => '智利比索 (CLP\$)';

  @override
  String get currencyCop => '哥伦比亚比索 (COP\$)';

  @override
  String get currencyPln => '波兰兹罗提 (zł)';

  @override
  String get currencyCzk => '捷克克朗 (Kč)';

  @override
  String get currencyHuf => '匈牙利福林 (Ft)';

  @override
  String get currencySek => '瑞典克朗 (SEK)';

  @override
  String get currencyNok => '挪威克朗 (NOK)';

  @override
  String get currencyDkk => '丹麦克朗 (DKK)';

  @override
  String get currencyRon => '罗马尼亚列伊 (RON)';

  @override
  String get currencyUah => '乌克兰格里夫纳 (₴)';

  @override
  String get currencyTry => '土耳其里拉 (₺)';

  @override
  String get currencyAed => '阿联酋迪拉姆 (AED)';

  @override
  String get currencySar => '沙特里亚尔 (SAR)';

  @override
  String get currencyIls => '以色列新谢克尔 (₪)';

  @override
  String get currencyZar => '南非兰特 (ZAR)';

  @override
  String get currencyEgp => '埃及镑 (EGP)';

  @override
  String get currencyNgn => '尼日利亚奈拉 (NGN)';

  @override
  String get primaryBikeTitle => '主力自行车';

  @override
  String get primaryBikeLabel => '选择主力自行车';

  @override
  String get primaryBikeNone => '未选择主力自行车';

  @override
  String get primaryBikeEmpty => '添加自行车以选择主力自行车。';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageUkrainian => '乌克兰语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languageItalian => '意大利语';

  @override
  String get languageChinese => '简体中文';

  @override
  String get biometricToggleTitle => 'FaceID/TouchID 解锁';

  @override
  String get biometricToggleSubtitle => '启动时要求生物识别';

  @override
  String get subscriptionTitle => '订阅';

  @override
  String get proStatus => 'Pro';

  @override
  String get freeStatus => '免费';

  @override
  String get upgradeToPro => '升级到 Pro';

  @override
  String get cancelPro => '取消 Pro';

  @override
  String get proRequiredMessage => '仅 PROS.TO Pro 可用。';

  @override
  String get stravaTitle => 'Strava';

  @override
  String get stravaConnected => 'Strava 已连接';

  @override
  String get stravaDisconnected => 'Strava 未连接';

  @override
  String get stravaLocked => 'Strava 同步仅 Pro 可用';

  @override
  String get stravaConnectRequired => '连接 Strava 以同步。';

  @override
  String get stravaSessionExpired => 'Strava 会话已过期，请重新连接。';

  @override
  String get stravaSyncFailed => 'Strava 同步失败，请重试。';

  @override
  String get stravaAuthFailed => '无法打开 Strava，请重试。';

  @override
  String get stravaImporting => '正在导入 Strava 自行车...';

  @override
  String get stravaImportBikes => '从 Strava 导入自行车';

  @override
  String get stravaImportFailed => 'Strava 导入失败，请重试。';

  @override
  String stravaImportResult(Object added, Object linked, Object skipped) {
    return '已导入 $added，已关联 $linked，已跳过 $skipped。';
  }

  @override
  String get connectStrava => '连接 Strava';

  @override
  String get disconnectStrava => '断开 Strava';

  @override
  String get accountTitle => '账户';

  @override
  String get phoneAuthStub => '手机号登录即将推出。';

  @override
  String get openAuth => '打开登录';

  @override
  String get aboutTitle => '关于';

  @override
  String versionLabel(Object version) {
    return '版本 $version';
  }

  @override
  String get paywallTitle => 'PROS.TO Pro';

  @override
  String get proTitle => 'PROS.TO Pro';

  @override
  String get proSubtitle => '解锁高级维护与同步功能。';

  @override
  String get proBenefitStrava => 'Strava 同步';

  @override
  String get proBenefitUnlimited => '无限自行车与组件';

  @override
  String get proBenefitAlerts => '智能维护提醒';

  @override
  String get proPrice => '\$5 / 月';

  @override
  String get proPriceNote => '随时取消';

  @override
  String get startPro => '开始 Pro';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get phoneAuthTitle => '手机注册';

  @override
  String get phoneAuthSubtitle => '使用手机号登录（演示）';

  @override
  String get phoneNumberLabel => '手机号';

  @override
  String get otpLabel => '验证码';

  @override
  String get continueLabel => '继续';

  @override
  String get unlockTitle => '解锁 PROS.TO';

  @override
  String get unlockSubtitle => '使用生物识别继续';

  @override
  String get unlockAction => '解锁';

  @override
  String get unlockReason => '请验证以解锁 PROS.TO';

  @override
  String get unlockDisableBiometrics => '关闭生物识别';
}
