import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({
    super.key,
    required this.list,
    required this.storage,
    required this.id,
  });

  final List<String> list;
  final FlutterSecureStorage storage;
  final String id;

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
    _loadValue();
    setState(() {});
  }

  _loadValue() async {
    String? val = await widget.storage.read(key: widget.id);
    dropdownValue = val ?? widget.list.first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.black,
          width: 4.0, // This would be the width of the underline
        ))),
        child: DropdownButton<String>(
          value: dropdownValue ?? "",
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
              widget.storage.write(key: widget.id, value: value);
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
