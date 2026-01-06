import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../../core/providers.dart';
import '../../app/theme/velpas_theme.dart';

class BiometricGate extends ConsumerStatefulWidget {
  const BiometricGate({
    super.key,
    required this.enabled,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  ConsumerState<BiometricGate> createState() => _BiometricGateState();
}

class _BiometricGateState extends ConsumerState<BiometricGate> {
  bool _unlocked = false;
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    _maybeUnlock();
  }

  @override
  void didUpdateWidget(covariant BiometricGate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.enabled && widget.enabled) {
      _unlocked = false;
      _maybeUnlock();
    }
    if (!widget.enabled) {
      _unlocked = true;
    }
  }

  Future<void> _maybeUnlock() async {
    if (!widget.enabled || _checking) return;
    setState(() {
      _checking = true;
    });
    final service = ref.read(biometricServiceProvider);
    final canCheck = await service.canCheck();
    if (!mounted) return;
    if (!canCheck) {
      setState(() {
        _unlocked = true;
        _checking = false;
      });
      return;
    }
    final result = await service.authenticate();
    if (!mounted) return;
    setState(() {
      _unlocked = result;
      _checking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || _unlocked) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: VelPasColors.bg0,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, size: 56, color: VelPasColors.champagne),
            const SizedBox(height: 16),
            Text(
              context.l10n.unlockTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.unlockSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checking ? null : _maybeUnlock,
              child: Text(context.l10n.unlockAction),
            ),
          ],
        ),
      ),
    );
  }
}
