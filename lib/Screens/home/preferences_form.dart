import 'package:firebasetest/shared/constants.dart';
import 'package:flutter/material.dart';

class PreferencesForm extends StatefulWidget {
  const PreferencesForm({Key? key}) : super(key: key);

  @override
  State<PreferencesForm> createState() => _PreferencesFormState();
}

class _PreferencesFormState extends State<PreferencesForm> {
  final List<String> strawberries = ['0', '1', '2', '3', '4'];

  int? _curCol;
  final TextEditingController _curName = TextEditingController();
  String? _curNum = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        const Text(
          'Set/Update Your Preferences',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: inputDecor,
          controller: _curName,
          validator: (val) => val!.isEmpty ? "please enter a name" : null,
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField(
          decoration: inputDecor,
          isExpanded: true,
          hint: const Text('Choose Number of Strawberries'),
          onChanged: (newValue) {
            setState(() {
              _curNum = newValue.toString();
            });
          },
          items: strawberries.map((berry) {
            return DropdownMenuItem(
              child: Text('$berry Strawberries'),
              value: berry,
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Slider(
          min: 100,
          max: 900,
          value: (_curCol ?? 100).toDouble(),
          activeColor: Colors.red[_curCol ?? 100],
          inactiveColor: const Color.fromARGB(255, 194, 178, 183),
          divisions: 8,
          onChanged: ((value) {
            setState(() {
              _curCol = value.round();
            });
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () async {},
          icon: const Icon(Icons.update),
          label: const Text('Update'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
        )
      ]),
    );
  }
}
