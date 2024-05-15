import 'package:ewallet/Models/Wallet.dart';
import 'package:ewallet/Models/WalletCard.dart';
import 'package:ewallet/Screens/widget/History.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../Models/User.dart';
import '../../controllers/Provider.dart';
import 'AddWallet.dart';

class Dashboard extends StatefulWidget {
  Dashboard(this.user, {Key? key}) : super(key: key);
  User user;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List walletsIDs = [];

  @override
  void initState() {
    context.read<Providers>().setWallets(widget.user.iD);

    super.initState();
  }

  totalBalance(List<WalletCard> walletCard) {
    double balance = 0;
    for (int i = 0; i < walletCard.length; i++) {
      balance += walletCard[i].balance;
    }
    return balance;
  }

  getWalletsIDs(wallets) {
    for (int i = 0; i < wallets.length; i++) {
      walletsIDs.add(wallets[i].walletID);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Wallet> wallets = context.watch<Providers>().wallets;
    List<WalletCard> walletCard = context.watch<Providers>().cards;
    getWalletsIDs(wallets);

    return Scaffold(
      backgroundColor: const Color(0xFFE8F6F6),
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "allWallet",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: walletsIDs.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "There is no wallets yet",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AddWallet(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("ADD WALLET NOW"),
                ),
              ],
            ))
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    color: Theme.of(context).secondaryHeaderColor,
                    height: 200,
                    width: double.infinity,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "totalBalance",
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFFA8ADDD)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$${(totalBalance(walletCard).toStringAsFixed(2))}",
                        style:
                            const TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      History(walletsIDs.toSet().toList(), true, walletCard),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
