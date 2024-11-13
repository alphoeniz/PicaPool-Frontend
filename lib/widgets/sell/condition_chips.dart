import 'package:flutter/material.dart';

class ConditionChips extends StatefulWidget {
  const ConditionChips({super.key});

  @override
  State<ConditionChips> createState() => _ConditionChipsState();
}

class _ConditionChipsState extends State<ConditionChips> {
  static String? category;
  static bool? newSelected;
  static bool? usedSelected;
  static bool? repairedSelected;
  static bool? overUsedSelected;
  static bool? gentlyUsedSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // New
        ChoiceChip(
          label: const Text("New"),
          selected: newSelected ?? false,
          onSelected: (value) {
            setState(() {
              value = newSelected ?? false;
            });
          },
        ),

        // Gently used
        Visibility(
          visible: category?.trim().toLowerCase() == "clothes",
          child: ChoiceChip(
            label: const Text("Gently Used"),
            selected: gentlyUsedSelected ?? false,
            onSelected: (value) {
              setState(() {
                value = gentlyUsedSelected ?? false;
              });
            },
          ),
        ),

        // Used
        ChoiceChip(
          label: const Text("Used"),
          selected: usedSelected ?? false,
          onSelected: (value) {
            setState(() {
              value = usedSelected ?? false;
            });
          },
        ),

        // Repaired
        Visibility(
          // once this is equal to books we show overused
          visible: category?.trim().toLowerCase() != "books" ||
              category?.trim().toLowerCase() != "clothes",
          child: ChoiceChip(
            label: const Text("Repaired"),
            selected: repairedSelected ?? false,
            onSelected: (value) {
              setState(() {
                value = repairedSelected ?? false;
              });
            },
          ),
        ),

        // Overused
        Visibility(
          visible: category?.trim().toLowerCase() == "books",
          child: ChoiceChip(
            label: const Text("Overused"),
            selected: overUsedSelected ?? false,
            onSelected: (value) {
              setState(() {
                value = overUsedSelected ?? false;
              });
            },
          ),
        ),
      ],
    );
  }
}
