import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Services/database.dart';
import 'package:firebasetest/models/userData.dart';
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
  String? _curNum;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder<UserData>(
        stream: DataBaseService(uid: uid).userData,
        builder: (context, snapshot) {
          //if (snapshot.hasData) {

          UserData? userData =
              UserData(uid: '', color: 100, name: 'new user', number: '0');

          if (snapshot.hasData) {
            userData = snapshot.data;
            _curName.text = userData!.name;
          }
          //    }
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
                value: userData.number,
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
                value: (_curCol ?? userData.color.toDouble()).toDouble(),
                activeColor: Colors.red[_curCol ?? (userData.color)],
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DataBaseService(uid: uid).updateUserData(
                        _curNum ?? userData!.number,
                        _curName.text,
                        _curCol ?? userData!.color);

                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.update),
                label: const Text('Update'),
                style: ElevatedButton.styleFrom(primary: Colors.pink),
              )
            ]),
          );
        });
  }
}
