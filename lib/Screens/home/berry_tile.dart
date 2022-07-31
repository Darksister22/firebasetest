import 'package:firebasetest/models/strawmodel.dart';
import 'package:flutter/material.dart';

class BerryTile extends StatelessWidget {
  final StrawBerry berry;
  const BerryTile({Key? key, required this.berry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.red[berry.color],
          ),
          title: Text(berry.name),
          subtitle: Text(berry.number),
        ),
      ),
    );
  }
}
