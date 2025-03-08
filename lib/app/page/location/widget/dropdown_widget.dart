import 'package:flutter/material.dart';

import 'package:flutter_countries_states/domain/entity/location_entity.dart';

class LocationDropdown extends StatelessWidget {
  final String labelText;
  final List<LocationEntity> items;
  final LocationEntity? value;
  final bool isLoading;
  final Function(LocationEntity?) onChanged;
  final String? hintText;
  final String? errorText;
  final bool isDisabled;
  final Widget? prefix;
  final VoidCallback? onTap;

  const LocationDropdown({
    Key? key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.value,
    this.isLoading = false,
    this.hintText,
    this.errorText,
    this.isDisabled = false,
    this.prefix,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEmpty = items.isEmpty && !isLoading;
    final isEnabled = !isLoading && !isDisabled && !isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isEnabled ? null : theme.disabledColor,
              ),
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null
                  ? theme.colorScheme.error
                  : theme.brightness == Brightness.dark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
              width: errorText != null ? 1.5 : 1.0,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isEnabled
                ? theme.brightness == Brightness.dark
                    ? Colors.grey.shade800.withOpacity(0.5)
                    : theme.cardColor
                : theme.brightness == Brightness.dark
                    ? Colors.grey.shade800.withOpacity(0.3)
                    : Colors.grey.shade100,
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField<LocationEntity>(
                value: value,
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: isEnabled ? null : theme.disabledColor,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                  hintText: hintText ?? 'Select ${labelText.toLowerCase()}',
                  hintStyle: TextStyle(color: theme.hintColor),
                  prefixIcon: prefix,
                  isDense: true,
                ),
                menuMaxHeight: 300,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isEnabled ? null : theme.disabledColor,
                ),
                dropdownColor: theme.brightness == Brightness.dark ? Colors.grey.shade800 : Colors.white,
                items: isEmpty
                    ? []
                    : items.map((LocationEntity item) {
                        return DropdownMenuItem<LocationEntity>(
                          value: item,
                          child: Text(
                            item.value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                onChanged: isEnabled ? onChanged : null,
                onTap: onTap,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              errorText!,
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        if (isEmpty && !isLoading)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 4),
            child: Text(
              'No options available',
              style: TextStyle(
                color: theme.hintColor,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
      ],
    );
  }
}
