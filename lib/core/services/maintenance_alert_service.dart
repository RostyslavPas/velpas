import 'package:flutter/widgets.dart';

import '../localization/app_localizations_ext.dart';
import '../../data/db/daos/meta_dao.dart';
import '../../data/models/component_models.dart';
import '../../data/repositories/component_repository.dart';
import 'notification_service.dart';

enum AlertLevel {
  ok,
  watch,
  replaceSoon,
  replaceNow,
}

class MaintenanceAlertService {
  MaintenanceAlertService({
    required this.componentRepository,
    required this.metaDao,
    required this.notificationService,
  });

  final ComponentRepository componentRepository;
  final MetaDao metaDao;
  final NotificationService notificationService;

  Future<void> checkAlerts(BuildContext context, {int? bikeId}) async {
    final snapshots =
        await componentRepository.fetchActiveWearSnapshots(bikeId: bikeId);
    if (snapshots.isEmpty) return;

    await notificationService.init();
    final allowed = await notificationService.requestPermissions();
    if (!allowed) return;

    for (final snapshot in snapshots) {
      final wear = _computeWear(snapshot.component, snapshot.bikeKm);
      final status = _statusFromWear(wear);
      final key = 'component_alert_${snapshot.component.id}';
      final previous = await metaDao.getValue(key);

      if (status == AlertLevel.ok) {
        if (previous != AlertLevel.ok.name) {
          await metaDao.setValue(key, AlertLevel.ok.name);
        }
        continue;
      }

      if (!_shouldNotify(previous, status)) {
        await metaDao.setValue(key, status.name);
        continue;
      }

      final componentName =
          '${snapshot.component.brand} ${snapshot.component.model}'.trim();
      final wearPercent = (wear * 100).round();
      final title = status == AlertLevel.watch
          ? context.l10n.alertTitleWatch
          : context.l10n.alertTitleReplace;
      final body = switch (status) {
        AlertLevel.watch =>
          context.l10n.alertBodyWatch(componentName, snapshot.bikeName, wearPercent),
        AlertLevel.replaceNow => context.l10n
            .alertBodyReplaceNow(componentName, snapshot.bikeName, wearPercent),
        _ => context.l10n
            .alertBodyReplace(componentName, snapshot.bikeName, wearPercent),
      };

      await notificationService.show(
        id: snapshot.component.id,
        title: title,
        body: body,
      );
      await metaDao.setValue(key, status.name);
    }
  }

  double _computeWear(ComponentItem component, int bikeKm) {
    if (component.expectedLifeKm <= 0) return 0;
    final wear = (bikeKm - component.installedAtBikeKm) /
        component.expectedLifeKm;
    if (wear.isNaN || wear.isInfinite) return 0;
    return wear < 0 ? 0 : wear;
  }

  AlertLevel _statusFromWear(double wear) {
    if (wear >= 1.0) return AlertLevel.replaceNow;
    if (wear >= 0.85) return AlertLevel.replaceSoon;
    if (wear >= 0.7) return AlertLevel.watch;
    return AlertLevel.ok;
  }

  bool _shouldNotify(String? previous, AlertLevel current) {
    if (current == AlertLevel.watch) {
      return previous != AlertLevel.watch.name &&
          previous != AlertLevel.replaceSoon.name &&
          previous != AlertLevel.replaceNow.name;
    }
    if (current == AlertLevel.replaceSoon) {
      return previous != AlertLevel.replaceSoon.name &&
          previous != AlertLevel.replaceNow.name;
    }
    return previous != AlertLevel.replaceNow.name;
  }
}
