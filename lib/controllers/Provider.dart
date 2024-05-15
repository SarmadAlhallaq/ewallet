import 'package:ewallet/Models/User.dart';
import 'package:ewallet/Models/WalletCard.dart';
import 'package:ewallet/controllers/WalletController.dart';
import 'package:flutter/cupertino.dart';

import '../Models/Wallet.dart';
import 'CardController.dart';

class Providers with ChangeNotifier {
  List<Wallet> _wallets = [];

  List<Wallet> get wallets => _wallets;
  List<WalletCard> _cards = [];

  List<WalletCard> get cards => _cards;
  User _user = User(0, "fName", "sName", "email", "password");

  User get user => _user;

  int _uID = 0;

  int get uID => _uID;

  setWallets(int uID) async {
    _uID = uID;
    if (uID == -1) {
      _wallets = [];
      _cards = [];
      notifyListeners();
      return;
    }
    var walletList = await WalletController().getWallets(uID);
    if (walletList == "You have no wallets") {
      walletList = [];
    }

    _wallets = [];
    _cards = [];
    for (int i = 0; i < walletList.length; i++) {
      Map card = await CardController().getCard(walletList[i]["wID"]);

      _wallets.add(Wallet(
        walletList[i]["wID"],
        walletList[i]["uID"],
        walletList[i]["wType"],
        walletList[i]["wName"],
      ));
      _cards.add(WalletCard(
          card["cID"],
          card["cardType"],
          card["CardNumber"],
          card["nameOnCard"],
          card["expiryDate"],
          card["balance"],
          card["wID"]));
    }
  }

  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  addWallet(Wallet wallet) {
    _wallets.add(wallet);
    notifyListeners();
  }
}
