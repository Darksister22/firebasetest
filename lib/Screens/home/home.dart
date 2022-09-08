import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/Screens/home/berry_list.dart';
import 'package:firebasetest/Screens/home/preferences_form.dart';
import 'package:firebasetest/Services/database.dart';
import 'package:firebasetest/Services/google_sign_in.dart';
import 'package:firebasetest/models/strawmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: const Color.fromARGB(223, 255, 237, 237),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: const PreferencesForm(),
            );
          });
    }

    return StreamProvider<List<StrawBerry>?>.value(
      value: DataBaseService()
          .berries, //this provider is constantly listening to the changes in the collection.
      initialData: null,
      child: Scaffold(
          backgroundColor: Colors.pink[100],
          appBar: AppBar(
            backgroundColor: Colors.pink[500],
            title: const Text('Home'),
            actions: [
              TextButton.icon(
                onPressed: () async {
                  final provider = Provider.of<GoogleSignInProvider>(context,
                      listen: false); //creating an instance of the class here.
                  await provider.googleLogout();
                },
                label: const Text('Logout'),
                style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Colors.white)),
                icon: const Icon(Icons.logout),
              ),
              Container(
                color: Colors.white,
                width: 2,
              ),
              TextButton.icon(
                  onPressed: () => _showSettingPanel(),
                  icon: const FaIcon(
                    FontAwesomeIcons.userGear,
                    size: 20,
                  ),
                  style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Colors.white)),
                  label: const Text('Preferences'))
            ],
          ),
          drawer: Container(
            color: Colors.pink,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL ??
                      'https://media.istockphoto.com/vectors/unknown-person-female-vector-id1345610707'),
                ),
                Text(
                  'Name: ' + (user.displayName ?? ' لا يوجد'),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                Text(
                  'Email: ' + (user.email ?? ' لا يوجد'),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/straw.png'),
                    fit: BoxFit.cover),
              ),
              child: const BerryList())),
    );
  }
}
