import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/prosto_theme.dart';
import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';
import '../settings/settings_controller.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.paywallTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.proTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(context.l10n.proSubtitle),
                const SizedBox(height: 16),
                _BenefitRow(text: context.l10n.proBenefitStrava),
                _BenefitRow(text: context.l10n.proBenefitUnlimited),
                _BenefitRow(text: context.l10n.proBenefitAlerts),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ProsToColors.champagneDeep),
                  ),
                  child: Row(
                    children: [
                      Text(
                        context.l10n.proPrice,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(context.l10n.proPriceNote),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await ref.read(settingsControllerProvider.notifier).setPro(true);
              if (context.mounted) context.pop();
            },
            child: Text(context.l10n.startPro),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () async {
              await ref.read(settingsControllerProvider.notifier).setPro(true);
              if (context.mounted) context.pop();
            },
            child: Text(context.l10n.restorePurchases),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: ProsToColors.champagne),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
