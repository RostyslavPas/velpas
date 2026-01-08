import '../../app/widgets/status_chip.dart';
import '../localization/gen/app_localizations.dart';

enum ComponentType {
  chain('chain'),
  cassette('cassette'),
  chainring('chainring'),
  powerMeter('powerMeter'),
  shifters('shifters'),
  rearDerailleur('rearDerailleur'),
  frontDerailleur('frontDerailleur'),
  wheels('wheels'),
  tires('tires'),
  brakes('brakes'),
  cockpit('cockpit'),
  stem('stem'),
  barTape('barTape'),
  other('other');

  const ComponentType(this.id);
  final String id;

  static ComponentType fromId(String id) {
    return ComponentType.values.firstWhere(
      (type) => type.id == id,
      orElse: () => ComponentType.other,
    );
  }
}

enum ComponentCategory { drivetrain, wheelsTires, brakes, cockpit, other }

class ComponentDefaults {
  static int expectedLifeKm(ComponentType type) {
    switch (type) {
      case ComponentType.chain:
        return 2500;
      case ComponentType.cassette:
        return 8000;
      case ComponentType.tires:
        return 3500;
      case ComponentType.wheels:
        return 50000;
      case ComponentType.powerMeter:
        return 100000;
      case ComponentType.chainring:
        return 12000;
      case ComponentType.brakes:
        return 6000;
      case ComponentType.cockpit:
        return 40000;
      case ComponentType.stem:
        return 50000;
      case ComponentType.barTape:
        return 2500;
      case ComponentType.shifters:
        return 40000;
      case ComponentType.rearDerailleur:
        return 30000;
      case ComponentType.frontDerailleur:
        return 30000;
      case ComponentType.other:
        return 5000;
    }
  }

  static String label(ComponentType type, AppLocalizations l10n) {
    switch (type) {
      case ComponentType.chain:
        return l10n.componentTypeChain;
      case ComponentType.cassette:
        return l10n.componentTypeCassette;
      case ComponentType.chainring:
        return l10n.componentTypeChainring;
      case ComponentType.powerMeter:
        return l10n.componentTypePowerMeter;
      case ComponentType.shifters:
        return l10n.componentTypeShifters;
      case ComponentType.rearDerailleur:
        return l10n.componentTypeRearDerailleur;
      case ComponentType.frontDerailleur:
        return l10n.componentTypeFrontDerailleur;
      case ComponentType.wheels:
        return l10n.componentTypeWheels;
      case ComponentType.tires:
        return l10n.componentTypeTires;
      case ComponentType.brakes:
        return l10n.componentTypeBrakes;
      case ComponentType.cockpit:
        return l10n.componentTypeCockpit;
      case ComponentType.stem:
        return l10n.componentTypeStem;
      case ComponentType.barTape:
        return l10n.componentTypeBarTape;
      case ComponentType.other:
        return l10n.componentTypeOther;
    }
  }
}

ComponentCategory categoryFor(ComponentType type) {
  switch (type) {
    case ComponentType.chain:
    case ComponentType.cassette:
    case ComponentType.chainring:
    case ComponentType.powerMeter:
    case ComponentType.shifters:
    case ComponentType.rearDerailleur:
    case ComponentType.frontDerailleur:
      return ComponentCategory.drivetrain;
    case ComponentType.wheels:
    case ComponentType.tires:
      return ComponentCategory.wheelsTires;
    case ComponentType.brakes:
      return ComponentCategory.brakes;
    case ComponentType.cockpit:
    case ComponentType.stem:
    case ComponentType.barTape:
      return ComponentCategory.cockpit;
    case ComponentType.other:
      return ComponentCategory.other;
  }
}

class WearStatus {
  static StatusLevel statusFromWear(double wear) {
    if (wear >= 0.85) {
      return StatusLevel.danger;
    }
    if (wear >= 0.7) {
      return StatusLevel.watch;
    }
    return StatusLevel.ok;
  }
}
