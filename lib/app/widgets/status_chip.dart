import 'package:flutter/material.dart';
import '../theme/velpas_theme.dart';

enum StatusLevel { ok, watch, danger }

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.level,
  });

  final String label;
  final StatusLevel level;

  Color get _color {
    switch (level) {
      case StatusLevel.ok:
        return VelPasColors.ok;
      case StatusLevel.watch:
        return VelPasColors.warn;
      case StatusLevel.danger:
        return VelPasColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _color.withOpacity(0.6)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
