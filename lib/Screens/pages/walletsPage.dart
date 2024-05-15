import 'package:ewallet/Models/User.dart';
import 'package:ewallet/Screens/pages/AddWallet.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../Models/Wallet.dart';
import '../../Models/WalletCard.dart';
import '../../controllers/Provider.dart';

class WalletsPage extends StatefulWidget {
  WalletsPage(this.user, {Key? key}) : super(key: key);
  User user;

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  @override
  Widget build(BuildContext context) {
    List<Wallet> wallets = context.watch<Providers>().wallets;
    List<WalletCard> walletCard = context.watch<Providers>().cards;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My wallets",
          style: TextStyle(fontSize: 20),
        ),
      ),
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: wallets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: ListTile(
                        onTap: () {},
                        title: Text(
                          "${walletCard[index].cardType == "PayPal" ? "**** " * 3 : "*" * 8}${walletCard[index].cardType == "PayPal" ? "**** " * 3 : walletCard[index].cardNumber.substring(15)}${" ${walletCard[index].cardType}"}",
                          style: const TextStyle(
                              color: Color(0xFF3D6670), fontSize: 13),
                        ),
                        subtitle: Text(
                          "${"\$"}${walletCard[index].balance}",
                          style: const TextStyle(
                              color: Color(0xFF3D6670), fontSize: 17),
                        ),
                        leading: Image.asset(
                          "assets/images/${walletCard[index].cardType}.png",
                          width: 100,
                        ),
                      ),
                    );
                  }),
              Container(
                padding: const EdgeInsets.all(18),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: AddWallet(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Icon(
                            Icons.wallet,
                            size: 50,
                            color: Color(0xFFA8ADDD),
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: const Text(
                          "ADD NEW WALLET",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
