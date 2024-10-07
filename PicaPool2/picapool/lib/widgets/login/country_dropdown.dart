import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

class CountryDropdown extends StatefulWidget {
  const CountryDropdown({
    Key? key,
    required this.onSelect,
    required this.countries,
  }) : super(key: key);

  final Function(CountryFlag) onSelect;
  final List<CountryFlag> countries;

  @override
  // ignore: library_private_types_in_public_api
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  late CountryFlag selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.countries.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff333399).withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3)
          )
        ],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xffBDBDBD), width: 1.2)),
      child: DropdownButton<CountryFlag>(
        padding: const EdgeInsets.only(left: 12),
        borderRadius: BorderRadius.circular(16),
        focusColor: Colors.transparent,
        iconEnabledColor: const Color(0xffAAAAAA),
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 32,
        ),
        isExpanded: true,
        underline: Container(),
        value: selectedCountry,
        onChanged: (CountryFlag? value) {
          if (value != null) {
            setState(() {
              selectedCountry = value;
            });
            widget.onSelect(value);
          }
        },
        items: widget.countries
            .map<DropdownMenuItem<CountryFlag>>((CountryFlag value) {
          return DropdownMenuItem<CountryFlag>(
            value: value,
            child: Row(
              children: [
                value,
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
