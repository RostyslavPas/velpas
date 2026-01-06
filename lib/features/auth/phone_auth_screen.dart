import 'package:flutter/material.dart';

import '../../app/widgets/v_card.dart';
import '../../core/localization/app_localizations_ext.dart';

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.phoneAuthTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          VCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.phoneAuthSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: context.l10n.phoneNumberLabel),
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: context.l10n.otpLabel),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(context.l10n.continueLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
