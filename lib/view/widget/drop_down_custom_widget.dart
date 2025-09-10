
import 'package:flutter/material.dart';


class DropDownCustomWidget extends StatefulWidget {
  final List<String> list;
  const DropDownCustomWidget({super.key, required this.list});

  @override
  State<DropDownCustomWidget> createState() => _DropDownCustomWidget();
}

class _DropDownCustomWidget extends State<DropDownCustomWidget> {
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    dropdownValue=widget.list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(height: 2, color: Colors.deepPurpleAccent),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}


