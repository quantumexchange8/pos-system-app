import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  final List<String> dropdownMenuEntries;
  final String initialSelectedItem;
  final ValueChanged<String>? onChanged;

  const CustomDropdownMenu({
    required this.dropdownMenuEntries,
    required this.initialSelectedItem,
    this.onChanged,
  });

  @override
  _CustomDropdownMenuState createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  late String _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedItem,
        items: widget.dropdownMenuEntries.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary), // Menu item text color
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedItem = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          }
        },
        //icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Arrow icon color
        selectedItemBuilder: (BuildContext context) {
          return widget.dropdownMenuEntries.map<Widget>((String value) {
            return Row(
              children: [
                Text(
                  value,
                  style: TextStyle(color: Colors.white, fontSize: 20), // Selected item text style (white)
                ),
                
              ],
            );
          }).toList();
        },
        iconEnabledColor: Colors.white,
        dropdownColor: Theme.of(context).colorScheme.background, // Background color of the dropdown menu
      ),
    );
  }
}
