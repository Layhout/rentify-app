import 'package:flutter/material.dart';
import 'package:rentify_app/common_widgets/theme/app_constants.dart';
import 'package:rentify_app/common_widgets/theme/theme_extensions.dart';

class MenuChip extends StatefulWidget {
  const MenuChip({super.key, required this.options, required this.label, required this.onSelected});

  final List<String> options;
  final String label;
  final ValueSetter<String> onSelected;

  @override
  State<MenuChip> createState() => _MenuChipState();
}

class _MenuChipState extends State<MenuChip> {
  late String _selectedOption = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: widget.options
          .map(
            (option) => MenuItemButton(
              onPressed: () {
                widget.onSelected(option);
                setState(() {
                  _selectedOption = option;
                });
              },
              child: Row(
                spacing: AppConstants.spacingXS,
                children: [
                  if (_selectedOption == option) Icon(Icons.check, size: AppConstants.spacingMD),
                  Text(option),
                ],
              ),
            ),
          )
          .toList(),
      builder: (_, MenuController controller, _) {
        return ActionChip(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.spacingXS),
          label: Row(
            spacing: AppConstants.spacingXS,
            children: [
              Text(widget.label, style: context.textTheme.labelMedium),
              Icon(Icons.keyboard_arrow_down, size: AppConstants.spacingMD),
            ],
          ),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
    );
  }
}
