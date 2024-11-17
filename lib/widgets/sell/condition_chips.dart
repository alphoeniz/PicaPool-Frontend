import 'package:flutter/material.dart';

class ConditionChips extends StatelessWidget {
  final String? category;
  final String? selectedCondition;
  final ValueChanged<String?> onConditionSelected;

  const ConditionChips({
    required this.category,
    required this.selectedCondition,
    required this.onConditionSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // Adds spacing between chips
      children: [
        // New
        PicapoolChoiceChip(
          icon: Icons.new_releases,
          label: "New",
          isSelected: selectedCondition == "new",
          onSelected: (isSelected) {
            onConditionSelected(isSelected ? "new" : null);
          },
        ),

        // Gently Used (visible for "clothing" category)
        if (category?.trim().toLowerCase() == "clothing")
          PicapoolChoiceChip(
            icon: Icons.clean_hands,
            label: "Gently Used",
            isSelected: selectedCondition == "gently used",
            onSelected: (isSelected) {
              onConditionSelected(isSelected ? "gently used" : null);
            },
          ),

        // Used
        PicapoolChoiceChip(
          icon: Icons.check_circle_outline,
          label: "Used",
          isSelected: selectedCondition == "used",
          onSelected: (isSelected) {
            onConditionSelected(isSelected ? "used" : null);
          },
        ),

        // Repaired (not visible for "books" and "clothing")
        if (category?.trim().toLowerCase() != "books" &&
            category?.trim().toLowerCase() != "clothing")
          PicapoolChoiceChip(
            icon: Icons.build,
            label: "Repaired",
            isSelected: selectedCondition == "repaired",
            onSelected: (isSelected) {
              onConditionSelected(isSelected ? "repaired" : null);
            },
          ),

        // Overused (visible for "books" category)
        if (category?.trim().toLowerCase() == "books")
          PicapoolChoiceChip(
            icon: Icons.library_books,
            label: "Overused",
            isSelected: selectedCondition == "over used",
            onSelected: (isSelected) {
              onConditionSelected(isSelected ? "over used" : null);
            },
          ),
      ],
    );
  }
}

class PicapoolChoiceChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const PicapoolChoiceChip({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        onSelected: onSelected,
        showCheckmark: false,
        selected: isSelected,
        label: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
