import 'package:flutter/material.dart';

class SettingsSpecificOption extends StatelessWidget {
  const SettingsSpecificOption({
    super.key,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.isDarkTheme,
    required this.tooltip,
    this.enable = true,
  });

  final String title;
  final Function onChanged;

  final bool enable;
  final bool value;

  final bool isDarkTheme;

  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final listTile = CheckboxListTile(
      value: value,
      onChanged: enable
          ? (valueChanged) {
              if (valueChanged!) onChanged();
            }
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
    return enable ? Tooltip(message: tooltip, child: listTile) : listTile;
  }
}
