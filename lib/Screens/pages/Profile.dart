import 'package:ewallet/Screens/pages/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/User.dart';
import '../../controllers/Provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late User user;
  pushToSignIn() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SignIn();
        },
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text("Log out"),
              onPressed: () async {
                await context.read<Providers>().setWallets(-1);
                await pushToSignIn();
              },
            ),
          ],
        ));
  }
}
