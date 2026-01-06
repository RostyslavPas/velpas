import 'package:flutter/material.dart';
import '../theme/velpas_theme.dart';

class VCard extends StatelessWidget {
  const VCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding,
      child: child,
    );

    return Material(
      color: VelPasColors.bg1,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: VelPasColors.stroke),
            gradient: const LinearGradient(
              colors: [VelPasColors.bg1, VelPasColors.bg2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}
