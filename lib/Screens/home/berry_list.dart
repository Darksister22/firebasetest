import 'package:firebasetest/models/strawmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BerryList extends StatefulWidget {
  const BerryList({Key? key}) : super(key: key);

  @override
  State<BerryList> createState() => _BerryListState();
}

class _BerryListState extends State<BerryList> {
  @override
  Widget build(BuildContext context) {
    final berries = Provider.of<List<StrawBerry>>(context);

    return ListView.builder(
      itemCount: berries.length,
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}
